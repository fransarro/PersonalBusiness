//
//  ProductDetailViewController.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import Foundation
import UIKit

fileprivate let reuseIdentifier = "productTransactionCell"

class ProductDetailViewController: UIViewController {
    
    
    @IBOutlet weak var totalCopyLbl: UILabel!
    @IBOutlet weak var euroAmountCopyLbl: UILabel!
    @IBOutlet weak var originalAmountCopyLbl: UILabel!
    @IBOutlet weak var skuCopyLbl: UILabel!

    @IBOutlet weak var transactionsTableView: UITableView!
    
    var presenter: ProductDetailViewToPresenterProtocol?
    var transactionsItemsCellVO = TransactionsItemsCellVO()


    override func viewDidLoad()  {
        super.viewDidLoad()
        self.setInitialUI()
        presenter?.viewDidLoaded()
        self.transactionsTableView.reloadData()
    }
    
    func setInitialUI() {
        self.transactionsTableView.dataSource = self
        self.transactionsTableView.delegate = self
        self.transactionsTableView.register(ProductTransactionCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension ProductDetailViewController: ProductDetailPresenterToViewProtocol {
    
    func loadViewWithData(total: String, item: ProductVO) {
        
        self.totalCopyLbl.text = AppConstants.total + total
        self.navigationItem.title = AppConstants.sku + item.sku
        self.skuCopyLbl.text = AppConstants.sku + item.sku
        self.originalAmountCopyLbl.text = AppConstants.originalCurrency
        self.euroAmountCopyLbl.text = AppConstants.eurCurrency
    }
    
    
    func loadTableCellItems(itemsCell: TransactionsItemsCellVO, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.transactionsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ProductTransactionCell else { return UITableViewCell() }
        
        let transaction = itemsCell[indexPath.row]
        let itemVO = TransactionItemCellVO(originalCurrencyAmount: transaction.originalCurrencyAmount, eurAmount: transaction.eurAmount)
        
        cell.loadView(itemVO: itemVO)
        return cell
    }
    
    
}

extension ProductDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.productVO?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return loadTableCellItems(itemsCell: transactionsItemsCellVO, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
