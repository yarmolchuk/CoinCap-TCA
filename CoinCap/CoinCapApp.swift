//
//  CoinCapApp.swift
//  CoinCap
//

import SwiftUI
import ComposableArchitecture

@main
struct CoinCapApp: App {
    var body: some Scene {
        WindowGroup {
            AssetListView(store: Store(initialState: AssetListReducer.State.idle, reducer: { AssetListReducer() }))
        }
    }
}
