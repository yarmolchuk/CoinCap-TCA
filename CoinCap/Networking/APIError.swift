//
//  APIError.swift
//  CoinCap
//

import Foundation

fileprivate struct Constants {
    static let badUrl = "Sorry, this URL is not valid"
    static let mapping = "Error raised, while mapping data"
    static let generic = "Sorry, try again later"
    static let invalidResponse = "Invalid response from the server"
    static let serverError = "Server error with status code: "
    static let network = "Network error: "
}

enum APIError: Equatable {
    case badUrl
    case mapping
    case generic
    case invalidResponse
    case serverError(statusCode: Int)
    case network(URLError)
}

extension APIError: Error {
    public var localizedDescription: String {
        switch self {
        case .badUrl: Constants.badUrl
        case .mapping: Constants.mapping
        case .generic: Constants.generic
        case .invalidResponse: Constants.invalidResponse
        case .serverError(let statusCode): "\(Constants.serverError)\(statusCode)"
        case .network(let urlError): "\(Constants.network)\(urlError.localizedDescription)"
        }
    }
}
