//
//  Rate.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

struct Rate: Codable {
    let from, to: String
    let rate: Decimal
}

struct RateVO {
    let from, to, rate: String
}

typealias Rates = [Rate]
