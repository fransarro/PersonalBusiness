//
//  Array+Extension.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
    
    func unique<T: Hashable>(by: (Element) -> (T)) -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}
