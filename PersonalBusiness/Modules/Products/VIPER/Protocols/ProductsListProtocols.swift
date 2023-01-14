//
//  ProductsListProtocols.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

protocol PListViewToPresenterProtocol : AnyObject {
    
    var view : PListPresenterToViewProtocol? {get set}
    var interactor : PListPresenterToInteractorProtocol? {get set}
    var router : PListPresenterToRouterProtocol? {get set}
    
    func getTransactionsAndRatesData()
    func getTransactionsData()
    func getRatesData()
    func getProductWithAllTransactions(transactions: Transactions, sku: String) -> ProductVO
    func getProductToDetail(sku: String, products: [ProductVO]) -> ProductVO?
}

protocol PListPresenterToViewProtocol : AnyObject {
    func getTransactions(transactions: [Transaction])
    func listTransactionsType(itemsCellVO: ProductListItemsCellVO)
    func getRates(rates: [Rate])
    func getProducts(products: [ProductVO])
    func error(message : String)
}

protocol PListPresenterToInteractorProtocol : AnyObject {
    var APIClient : APIClientProtocol? {get set}
    var presenter : PListInteractorToPresenterProtocol? {get set}
    
    func getTransactionsData()
    func getRatesData()
    func getTransactionsAndRatesData()
}

protocol PListInteractorToPresenterProtocol : AnyObject {
    func success(transactions : [Transaction])
    func success(rates : [Rate])
    func success(products: [ProductVO])
    func fail(errorMessage : String)
}


protocol PListPresenterToRouterProtocol : AnyObject {
    static func createModule() -> ProductsListViewController
}
