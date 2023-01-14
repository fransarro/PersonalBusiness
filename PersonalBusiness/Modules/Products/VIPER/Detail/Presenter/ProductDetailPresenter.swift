//
//  ProductDetailPresenter.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

class ProductDetailPresenter {

    var view: ProductDetailViewController?
    var productVO: ProductVO?
    var interactor: ProductDetailInteractor?
    
    init(productVO: ProductVO)
    {
        self.productVO = productVO
    }
    
    init(
        view: ProductDetailViewController,
        productVO: ProductVO)
    {
        self.view = view
        self.productVO = productVO
    }
    
    func getTotalAmount(){
        guard let productVO = productVO else {
            return
        }
        interactor?.calculateFinalAmount(product: productVO)
        interactor?.getOriginalAndEuroAmount(product: productVO)

    }
}

extension ProductDetailPresenter: ProductDetailViewToPresenterProtocol {
    func viewDidLoaded() {
        self.getTotalAmount()
    }
}

extension ProductDetailPresenter: ProductDetailInteractorToPresenterProtocol {
    
    func getCorrespondencyCell(transactionsItems: TransactionsItemsCellVO) {
        view?.transactionsItemsCellVO = transactionsItems
    }

    func viewDidLoad(total: Decimal) {
        let totalStr = total.formatAsCurrency(currencyCode: AppConstants.eurCurrency)
        let totalEur = totalStr.formatAsEur(text: totalStr)
        guard let productVO = self.productVO else {return}
        view?.loadViewWithData(total: totalEur, item: productVO)
    }
}
