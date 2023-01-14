//
//  Decimal+Extensions.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }

    func formatAsCurrency(currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.currencyCode = currencyCode
        formatter.roundingMode = .halfEven
        return formatter.string(from: self as NSNumber)!
    }

    func formatAsNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self as NSNumber)!
    }
}
