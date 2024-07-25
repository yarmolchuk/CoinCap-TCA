//
//  NetworkService.swift
//  CoinCap
//

import Combine
import Foundation
import Dependencies

// Define your dependency keys

struct NetworkingKey: DependencyKey {
    static let liveValue: Networking = Networking()
}

struct JSONDecoderKey: DependencyKey {
    static let liveValue = JSONDecoder()
}

extension DependencyValues {
    var networking: Networking {
        get { self[NetworkingKey.self] }
        set { self[NetworkingKey.self] = newValue }
    }

    var jsonDecoder: JSONDecoder {
        get { self[JSONDecoderKey.self] }
        set { self[JSONDecoderKey.self] = newValue }
    }
}

struct Networking {
    @Dependency(\.urlSession) private var session
    @Dependency(\.jsonDecoder) private var decoder

    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, APIError> {
        guard let url = endpoint.url else {
            return Fail(error: APIError.badUrl).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request(url, endpoint: endpoint))
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                if 200...299 ~= httpResponse.statusCode {
                    return data
                } else {
                    throw APIError.serverError(statusCode: httpResponse.statusCode)
                }
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> APIError in
                switch error {
                case is Swift.DecodingError:
                    return .mapping
                case let urlError as URLError:
                    return .network(urlError)
                default:
                    return .generic
                }
            }
            .eraseToAnyPublisher()
    }

    private func request(_ url: URL, endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        request.allHTTPHeaderFields = endpoint.headers
        request.timeoutInterval = 30
        
        return request
    }
}
