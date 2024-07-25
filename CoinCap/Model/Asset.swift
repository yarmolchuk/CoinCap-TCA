//
//  Asset.swift
//  CoinCap
//

import Foundation

struct AssetList: Codable {
    let data: [Asset]
}

struct Asset: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let symbol: String
    let changePercent24Hr: String
    let marketCapUsd: String
    let priceUsd: String
}
