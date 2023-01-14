//
//  Strings+Extensions.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

extension String {
    var decimalValueOrZero: Decimal {
        Decimal(string: self) ?? 0.0
    }
    
    func formatAsEur(text: String) -> String {
        var output = text
        output.removeFirst()
        output.append("€")
        return output
    }
}
