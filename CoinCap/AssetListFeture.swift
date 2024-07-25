//
//  CoinCapEffects.swift
//  CoinCap
//

import Foundation
import Combine
import Dependencies
import ComposableArchitecture

@Reducer
struct AssetListReducer {
    @ObservableState
    enum State {
        case idle
        case loading
        case failed(APIError)
        case loaded([Asset])
    }
    
    enum Action {
        case load
        case receivedAssetList(AssetList)
        case failed(APIError)
    }

    @Dependency(\.networking) private var networking
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .load:
            return .publisher {
                networking.request(endpoint: .assets(limit: 20))
                    .map { assetList -> Action in
                        .receivedAssetList(assetList)
                    }
                    .catch { error in
                        Just(.failed(.generic))
                    }
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }
            
        case .receivedAssetList(let assetList):
              if assetList.data.isEmpty {
                  state = .failed(.invalidResponse)
              } else {
                  state = .loaded(assetList.data)
              }
              return .none
            
        default:
            return .none
        }
    }
}
