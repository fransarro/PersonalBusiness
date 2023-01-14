//
//  ProductDetailInteractor.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

class ProductDetailInteractor: ProductDetailPresenterToInteractorProtocol {
   
    var presenter: ProductDetailInteractorToPresenterProtocol?
    
    init(presenter: ProductDetailInteractorToPresenterProtocol)
    {
        self.presenter = presenter
    }
    
    private func getEuroAmount(_ transaction: Transaction) -> Decimal {
        let currencyRates = CurrencyRates.shared

        if transaction.currency != AppConstants.eurCurrency {
            let rate = currencyRates.getRateBetween(from: transaction.currency, to: AppConstants.eurCurrency)
            return transaction.amount * rate
        }

        return transaction.amount
    }
    
    func calculateFinalAmount(product: ProductVO) {
        let total = product.transactions.reduce(0.0) { accumulator, transaction in
            accumulator + getEuroAmount(transaction)
        }
        self.presenter?.viewDidLoad(total: total)
    }
    
    func getOriginalAndEuroAmount(product: ProductVO) {
        var transactionsItems = TransactionsItemsCellVO()
        for transaction in product.transactions {
            
            let originalAmount = transaction.amount.formatAsNumber()
            let originalCurrencyOutput = "\(originalAmount) \(transaction.currency)"
            
            let euroAmount = getEuroAmount(transaction).formatAsNumber()
            let euroOutput = "\(euroAmount) \(AppConstants.eurCurrency)"

            let transactionItem = TransactionItemCellVO(originalCurrencyAmount: originalCurrencyOutput, eurAmount: euroOutput)
            transactionsItems.append(transactionItem)
        }
        self.presenter?.getCorrespondencyCell(transactionsItems: transactionsItems)
    }
}
