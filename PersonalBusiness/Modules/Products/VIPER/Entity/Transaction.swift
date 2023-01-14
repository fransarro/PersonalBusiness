//
//  Transaction.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

struct Transaction: Decodable, Equatable, Hashable {
    let sku, currency: String
    let amount: Decimal
}

typealias Transactions = [Transaction]
