//
//  ConversionRatesHelper.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

protocol FindMissingRatesProtocol {
    func setRates(rates: [Rate])
    func checkMissingRates(from currencies: [String]) -> [Rate]
}

class FindMissingRates {
    private var rates: [Rate] = []
    private var rateChecked: Set<String> = Set()

    private func getCurrencyRate(from: String, to: String) -> Decimal {
        rateChecked.removeAll()
        return getRecursiveRate(from: from, to: to, previousRate: 1)
    }

    private func getRecursiveRate(from: String, to: String, previousRate: Decimal) -> Decimal {
        let rateBetween: Decimal = getRateBetween(from: from, to: to)
        if rateBetween != 0 {
            return previousRate * rateBetween
        } else {
            rateChecked.insert(from)
            for rate in rates {
                if rate.from == from, !rateChecked.contains(rate.to) {
                    print(rate)
                    let foundRate = getRecursiveRate(from: rate.to, to: to,
                                                     previousRate: previousRate * rate.rate)
                    if foundRate != 0 {
                        return foundRate
                    }
                }
            }
        }

        return 0
    }

    private func getRateBetween(from: String, to: String) -> Decimal {
        return rates.first(where: { $0.from == from && $0.to == to })?.rate ?? 0
    }
}

extension FindMissingRates: FindMissingRatesProtocol {
    func setRates(rates: [Rate]) {
        self.rates = rates
    }

    func checkMissingRates(from currencies: [String]) -> [Rate] {
        let currenciesOtherThanEuros = currencies.filter {
            $0 != AppConstants.eurCurrency
        }
        var allRates = [Rate]()
        
        for currency in currenciesOtherThanEuros {
            let rate = rates.first(where: { $0.from == currency && $0.to == AppConstants.eurCurrency })
            if rate == nil {
                print("\(currency) rate is missing")

                let foundRate = getCurrencyRate(from: currency, to: AppConstants.eurCurrency)
                print("\(currency) found rate is \(foundRate)")

//                let textRate = NSDecimalNumber(decimal: foundRate).stringValue
                let newRate = Rate(from: currency, to: AppConstants.eurCurrency, rate: foundRate)
                allRates.append(newRate)
            }
        }
        return allRates
    }
}

class CurrencyRates {
    private var rates: [Rate] = []

    static var shared = CurrencyRates()

    private init() {}

    func setRates(rates: [Rate]) {
        self.rates = rates
    }

    func getRateBetween(from: String, to: String) -> Decimal {
        return rates.first(where: { $0.from == from && $0.to == to })?.rate ?? 1
    }
}
