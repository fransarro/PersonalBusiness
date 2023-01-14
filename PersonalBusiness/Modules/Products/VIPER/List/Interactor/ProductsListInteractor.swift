//
//  ProductsListInteractor.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

class ProductsListInteractor : PListPresenterToInteractorProtocol {
    var APIClient: APIClientProtocol?
    var presenter: PListInteractorToPresenterProtocol?
    var findMissingRates: FindMissingRatesProtocol

       init(findMissingRates: FindMissingRatesProtocol) {
           self.findMissingRates = findMissingRates
       }

       private func getAllCurrencies(from transactions: [Transaction]) -> [String] {
           return transactions.unique { $0.currency }.map { $0.currency }
       }

       private func findMissingRates(from transactions: [Transaction], and rates: [Rate]) {
           let currencies = getAllCurrencies(from: transactions)
           findMissingRates.setRates(rates: rates)
           let allRates = findMissingRates.checkMissingRates(from: currencies)
           CurrencyRates.shared.setRates(rates: allRates)
       }

       private func extractProducts(from transactions: [Transaction], and rates: [Rate]) -> [ProductVO] {
           findMissingRates(from: transactions, and: rates)

           let productDict = Dictionary(grouping: transactions, by: { $0.sku })
           return productDict.map {
               ProductVO(sku: $0.key, transactions: $0.value)
           }
       }
    
    
    func getTransactionsData() {
        APIClient?.getTransactions(completion: { result in
            switch result {
            case .success(let transactions):
                self.presenter?.success(transactions: transactions)
            case .failure(let error):
                self.presenter?.fail(errorMessage: error.localizedDescription)
            }
        })
    }

    func getRatesData() {
        APIClient?.getRates(completion: { result in
            switch result {
            case .success(let rates):
                self.presenter?.success(rates: rates)
            case .failure(let error):
                self.presenter?.fail(errorMessage: error.localizedDescription)
            }
        })
    }
    
    func getTransactionsAndRatesData() {
        APIClient?.getTransactions(completion: { result in
            switch result {
            case .success(let transactions):
                self.APIClient?.getRates(completion: { result in
                    switch result {
                    case .success(let rates):
                        let productsVO = self.extractProducts(from: transactions, and: rates)
                        self.presenter?.success(products: productsVO)
                    case .failure(let error):
                        self.presenter?.fail(errorMessage: error.localizedDescription)
                    }
                })
                self.presenter?.success(transactions: transactions)
            case .failure(let error):
                self.presenter?.fail(errorMessage: error.localizedDescription)
            }
        })
    }
    
}
