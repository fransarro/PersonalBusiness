//
//  ProductDetailRouter.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation
import UIKit

class ProductDetailRtr {
    static func createModule(navController: UINavigationController, productVO: ProductVO){
        let detailVC = ProductDetailViewController(nibName: "PDetailVC", bundle: nil)
        let presenter = ProductDetailPresenter(view: detailVC, productVO: productVO)
        let interactor = ProductDetailInteractor(presenter: presenter)
    
        presenter.interactor = interactor
        detailVC.presenter = presenter
        
        navController.pushViewController(detailVC, animated: true)
    }
}
