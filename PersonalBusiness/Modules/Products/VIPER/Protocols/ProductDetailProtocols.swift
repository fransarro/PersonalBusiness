//
//  ProductDetailProtocols.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation
import UIKit

protocol ProductDetailViewToPresenterProtocol : AnyObject {
    var view : ProductDetailViewController? {get set}
    var productVO: ProductVO? {get set}
    func viewDidLoaded()
}

protocol ProductDetailPresenterToViewProtocol : AnyObject {
    func loadViewWithData(total: String, item: ProductVO)
    func loadTableCellItems(itemsCell: TransactionsItemsCellVO, indexPath: IndexPath) -> UITableViewCell
}

protocol ProductDetailPresenterToInteractorProtocol : AnyObject {
    var presenter: ProductDetailInteractorToPresenterProtocol? {get set}
    func calculateFinalAmount(product: ProductVO)
    func getOriginalAndEuroAmount(product: ProductVO)

}

protocol ProductDetailInteractorToPresenterProtocol : AnyObject {
    func viewDidLoad(total: Decimal)
    func getCorrespondencyCell(transactionsItems: TransactionsItemsCellVO)
}
