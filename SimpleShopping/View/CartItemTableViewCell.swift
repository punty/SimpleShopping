//
//  CartItemTableViewCell.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 19/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell, ItemCellType {
    
    typealias ViewModel = CartCellViewModel

    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViewModel(viewModel: CartCellViewModel) {
        itemNameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        quantityLabel.text = viewModel.quantity
    }

}
