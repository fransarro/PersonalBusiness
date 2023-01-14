//
//  ProductDetailCell.swift
//  VIPER
//
//  Created by Francisco Javier Sarró Redondo on 11/1/23.
//

import UIKit

typealias TransactionsItemsCellVO = [TransactionItemCellVO]
struct TransactionItemCellVO {
    let originalCurrencyAmount: String
    var eurAmount: String
}


class ProductTransactionCell: UITableViewCell {
    
    let originalAmountLabel = UILabel()
    let euroAmountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func loadView(itemVO: TransactionItemCellVO) {
        self.originalAmountLabel.text = itemVO.originalCurrencyAmount
        self.euroAmountLabel.text = itemVO.eurAmount
        
    }
    
    func setupLayout() {
        selectionStyle = .none
        originalAmountLabel.numberOfLines = 1
        originalAmountLabel.font = UIFont.systemFont(ofSize: 13)
        originalAmountLabel.textAlignment = .left
        originalAmountLabel.translatesAutoresizingMaskIntoConstraints = false

        euroAmountLabel.numberOfLines = 1
        euroAmountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        euroAmountLabel.textAlignment = .right
        
        euroAmountLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(originalAmountLabel)
        addSubview(euroAmountLabel)

        NSLayoutConstraint.activate([
            originalAmountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            originalAmountLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            originalAmountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            originalAmountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
    
            euroAmountLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            euroAmountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            euroAmountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            euroAmountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
