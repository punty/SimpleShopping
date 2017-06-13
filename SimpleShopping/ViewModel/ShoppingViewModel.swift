//
//  ShoppingViewModel.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 16/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation
import SimpleNetwork


protocol PurchaseDelegate {
    func addToCart(item: Item)
    func removeFromCart(item: Item)
}

final class ShoppingViewModel {
    
    weak var delegate: RefreshViewControllerType?
    
    var userService: UserServiceType
    var itemService: ItemsServiceType
    
    lazy var viewModels: [ItemCellViewModel] = self.itemService.items.sorted(){
            item1, item2 in
        return item1.itemName < item2.itemName
        }.map {
        ItemCellViewModel(item: $0, purchaseDelegate: self)
    }
    
    var viewTitle = "Items"
    
    init(user: UserServiceType, items:ItemsServiceType) {
        self.userService = user
        self.itemService = items
    }
    
    var showCart = false
    
    func cartViewModel() -> CartViewModel {
        let serviceClient = ServiceClient()
        return CartViewModel(userService: userService, currencyService: CurrencyService(serviceClient:serviceClient))
    }
}

extension ShoppingViewModel: PurchaseDelegate {
    
    func addToCart(item: Item) {
        userService.addToCart(item: item)
        showCart = userService.currentUser.cart.count > 0
        delegate?.refreshUI()
    }
    
    func removeFromCart(item: Item) {
        userService.removeFromCart(item: item)
        showCart = userService.currentUser.cart.count > 0
        delegate?.refreshUI()
    }
}
