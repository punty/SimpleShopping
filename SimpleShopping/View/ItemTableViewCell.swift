//
//  ItemTableViewCell.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 16/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import UIKit

final class ItemTableViewCell: UITableViewCell, ItemCellType {

    @IBOutlet weak var itemImage: UIImageView!
   
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var shoppingStepper: ShoppingStepper!
    
    typealias ViewModel = ItemCellViewModel
    
    var viewModel: ItemCellViewModel!
    
    func updateViewModel(viewModel: ItemCellViewModel) {
        self.viewModel = viewModel
        itemLabel.text = viewModel.text
        itemImage.image = UIImage(named: viewModel.image)
        shoppingStepper.delegate = self
    }
}

extension ItemTableViewCell: ShoppingStepperDelegate {
    func valueDidUpdate(stepper: ShoppingStepper, increase: Bool) {
        if increase {
            viewModel.addItemToCart()
        } else {
            viewModel.removeItemFromCart()
        }
    }
}


