//
//  AssetListView.swift
//  CoinCap
//

import SwiftUI
import ComposableArchitecture

struct AssetListView: View {
    @Bindable var store: StoreOf<AssetListReducer>

    var body: some View {
        switch store.state {
        case .idle:
            Color.appBackground.onAppear {
                store.send(.load)
            }
        case .loading:
            ProgressView("Loading Assets...")
        case .failed(let error):
            ErrorView(errorMessage: error.localizedDescription)
        case .loaded(let assets):
            NavigationStack {
                List(assets) { asset in
                    AssetView(assetViewModel: AssetViewModel(asset: asset))
                        .listRowBackground(Color.appBackground)
                }
                .listStyle(PlainListStyle())
                .background(Color.appBackground)
                .navigationTitle("CoinCap")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}
