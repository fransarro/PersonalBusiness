//
//  ProductListCell.swift
//  PersonalBusiness
//
//  Created by Francisco Javier Sarró Redondo on 12/1/23.
//

import UIKit

typealias ProductListItemsCellVO = [ProductListItemCellVO]
struct ProductListItemCellVO {
    let sku: String
    var quantity: Int = 0
}

class ProductListCell : UITableViewCell {
    
    var presenter : ProductsListPresenter?
    var vc : ProductsListViewController?

    let titleLabel = UILabel()
    
    func initCell(itemVO: ProductVO, VC: ProductsListViewController?) {
        titleLabel.text = "\(itemVO.sku) \(AppConstants.uds.replacingOccurrences(of: "*", with: String(itemVO.transactions.count)))"
        self.vc = VC
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        selectionStyle = .none
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
}

