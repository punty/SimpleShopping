//
//  ItemCellViewModel.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 19/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation

//Here we can compose our protocol
struct ItemCellViewModel {
    
    var text: String
    var image: String
    
    var delegate: PurchaseDelegate
    
    private var itemModel: Item
    
    init (item: Item, purchaseDelegate: PurchaseDelegate) {
        itemModel = item
        delegate = purchaseDelegate
        text =  itemModel.itemName
        image = ""
    }
    
    func addItemToCart() {
        delegate.addToCart(item: itemModel)
    }
    
    func removeItemFromCart() {
        delegate.removeFromCart(item: itemModel)
    }
}
