//
//  ProductsListRouter.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation

class ProductsListRouter : PListPresenterToRouterProtocol {
    static func createModule() -> ProductsListViewController {
        
        let view = ProductsListViewController()
        let presenter : PListViewToPresenterProtocol & PListInteractorToPresenterProtocol = ProductsListPresenter()
        let interactor : PListPresenterToInteractorProtocol = ProductsListInteractor(findMissingRates: FindMissingRates())
        let router : PListPresenterToRouterProtocol = ProductsListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.APIClient = APIClient()
        
        return view
    }
}
