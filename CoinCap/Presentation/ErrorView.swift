//
//  ErrorView.swift
//  CoinCap
//

import SwiftUI

struct ErrorView: View {
    var errorMessage: String
    
    var body: some View {
        Text(errorMessage)
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    ErrorView(errorMessage: "Error")
}
