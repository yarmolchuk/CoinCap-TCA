//
//  AssetView.swift
//  CoinCap
//

import SwiftUI

struct AssetViewModel: Identifiable {
    var asset: Asset
    
    var id: String {
        asset.id
    }
    var name: String {
        asset.name
    }
    var symbol: String {
        asset.symbol
    }
    var price: String {
        asset.priceUsd.currencyFormattedValue()
    }
    var changePercent: String {
        asset.changePercent24Hr.percentFormattedValue()
    }
    var marketCap: String {
        asset.marketCapUsd.currencyFormattedValue()
    }
    var hasNegativeChanges: Bool {
        changePercent.hasPrefix("-")
    }
}

struct AssetView: View {
    var assetViewModel: AssetViewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(assetViewModel.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(assetViewModel.symbol)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(8)
            
            HStack {
                Text("Price")
                    .foregroundColor(.gray)
                VStack(alignment: .trailing) {
                    Text(assetViewModel.price)
                    Text(assetViewModel.changePercent)
                        .foregroundColor(assetViewModel.hasNegativeChanges ? .red : .green)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
            
            HStack {
                Text("Market cap")
                    .foregroundColor(.gray)
                Text(assetViewModel.marketCap)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
        }
        .background(Color.white)
        .cornerRadius(15)
    }
}

#Preview {
    let asset = Asset(
        id: "bitcoin",
        name: "Bitcoin",
        symbol: "BTC",
        changePercent24Hr: "4.6112912338284003",
        marketCapUsd: "1136551580407.9842430",
        priceUsd: "60867.8140898007")
    
    return AssetView(assetViewModel: AssetViewModel(asset: asset))
}
