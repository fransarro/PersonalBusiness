//
//  ProductsListPresenter.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

class ProductsListPresenter : PListViewToPresenterProtocol {
   
    weak var view: PListPresenterToViewProtocol?
    var interactor: PListPresenterToInteractorProtocol?
    var router: PListPresenterToRouterProtocol?

    func getTransactionsData() {
        interactor?.getTransactionsData()
    }
    
    func getRatesData() {
        interactor?.getRatesData()
    }
    
    func getTransactionsAndRatesData() {
        interactor?.getTransactionsAndRatesData()
    }
        
    func getProductWithAllTransactions(transactions: Transactions, sku: String) -> ProductVO {
        var transactionsVO = Transactions()
        var skuOutput = ""
        for transaction in transactions {
            if transaction.sku == sku {
                transactionsVO.append(transaction)
            }
        }
        
        if let _skuOutput = transactionsVO.first?.sku {
            skuOutput = _skuOutput
        }
        
        let productVO = ProductVO(sku: skuOutput, transactions: transactionsVO)
        
        return productVO
    }
    
    func getProductToDetail(sku: String, products: [ProductVO]) -> ProductVO? {
        return products.first(where: {$0.sku == sku})
    }

}

extension ProductsListPresenter : PListInteractorToPresenterProtocol {
    
    func success(products: [ProductVO]) {
        view?.getProducts(products: products)
    }
    
    func success(rates: [Rate]) {
        view?.getRates(rates: rates)
    }
    
    func success(transactions: [Transaction]) {
        view?.getTransactions(transactions: transactions)
        view?.listTransactionsType(itemsCellVO: getProductsItemsCellVO(transactions: transactions))
    }
    
    func getProductsItemsCellVO(transactions: [Transaction]) -> ProductListItemsCellVO {
        var productsItemCellVO = ProductListItemsCellVO()
        for transaction in transactions {
            productsItemCellVO.append(ProductListItemCellVO(sku: transaction.sku))
        }
        
        var sumSkusItems = ProductListItemsCellVO()
        let productsItemsSum = productsItemCellVO.sum(of: \.sku)
        
        for product in productsItemsSum {
            sumSkusItems.append(ProductListItemCellVO(sku: product.key, quantity: product.value))
        }
        
        return  sumSkusItems
    }
    
    func fail(errorMessage: String) {
        view?.error(message: errorMessage)
    }
    
    func listTransactionsType(transactions: [Transaction]) -> [String] {
        var skuTypes : [String] = []
        for transaction in transactions {
            skuTypes.append(transaction.sku)
        }
        return skuTypes.uniqued()
    }
    
}
