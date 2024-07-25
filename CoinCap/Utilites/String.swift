//
//  String.swift
//  CoinCap
//

import Foundation

extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    static let percent: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1
        return formatter
    }()
}

extension String {
    func currencyFormattedValue() -> String {
        guard let doubleValue = Double(self) else { return "NaN" }
        return Formatter.currency.string(from: NSNumber(value: doubleValue)) ?? self
    }
    
    func percentFormattedValue() -> String {
        guard let doubleValue = Double(self) else { return "NaN" }
        return Formatter.percent.string(from: NSNumber(value: doubleValue)) ?? self
    }
}
