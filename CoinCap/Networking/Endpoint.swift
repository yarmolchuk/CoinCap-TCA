//
//  Endpoint.swift
//  CoinCap
//

import Foundation

enum Endpoint {
    case assets(limit: Int)

    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coincap.io"
        return components
    }

    private var path: String {
        switch self {
        case .assets:
            return "/v2/assets"
        }
    }

    private var queryItems: [URLQueryItem]? {
        switch self {
        case .assets(let limit):
            return [URLQueryItem(name: "limit", value: "\(limit)")]
        }
    }

    var url: URL? {
        var components = baseComponents
        components.path = path
        components.queryItems = queryItems
        return components.url
    }

    var httpMethod: String {
        switch self {
        case .assets:
            return "GET"
        }
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}
