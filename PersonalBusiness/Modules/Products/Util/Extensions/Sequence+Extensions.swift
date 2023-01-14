//
//  Sequence+Extensions.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

extension Sequence {
    func sum<T: Hashable>(of property: (Element) -> T) -> [T: Int] {
        reduce(into: [:]) { $0[property($1), default: 0] += 1 }
    }
    func sum<T: Hashable, A: AdditiveArithmetic>(of property: (Element) -> T, by adding: (Element) -> A) -> [T: A] {
        reduce(into: [:]) { $0[property($1), default: .zero] += adding($1) }
    }
}
