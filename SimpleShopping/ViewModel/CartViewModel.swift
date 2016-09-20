//
//  CartViewModel.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 19/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation


final class CartViewModel {
    
    var userService: UserServiceType
    var currencyService: CurrencyServiceType
    var viewTitle = "My Cart"
    var currency: String
    var exchangeRate: Double?
    var total:String = ""
    var currencies: [Currency]?
    var viewModels: [CartCellViewModel]?
    var canBuy = false
    
    private var countItems: [Item: Int]
    weak var delegate: RefreshViewControllerType & InitializableViewController?
    
    init(userService: UserServiceType, currencyService: CurrencyServiceType) {
        self.userService = userService
        self.currencyService = currencyService
        self.currency = currencyService.currency
        countItems = [:]
        userService.currentUser.cart.forEach { item in
            if let count = countItems[item] {
                countItems[item] = count + 1
            } else {
                countItems[item] = 1
            }
        }
        self.currency = currencyService.currency
    }
    
    private func updatedViewModels(rate: Double) {
        let viewModels = countItems.map {
            item, count in
            return CartCellViewModel(name: item.itemName, price: item.price * rate, quantity: count, currency: self.currency)}
            .sorted() {
                item1, item2 in
                item1.name < item2.name }
        self.viewModels = viewModels
    }
    
    
    func initialize() {
        currencyService.currencyList() {
            currencies in
            self.currencies = currencies
            self.currencyService.exchangeRate(to: self.currency) { rate in
                if let exchange = rate {
                    self.updateRate(exchange: exchange, currency: self.currency)
                }
                DispatchQueue.main.async {
                    self.delegate?.initializeUI()
                }
            }
        }
    }
    
    private func updateRate(exchange: Double, currency: String) {
        canBuy = true
        self.exchangeRate = exchange
        self.currency = currency
        self.currencyService.currency = self.currency
        let totalPrice = self.countItems.reduce (0.0) {
            total, item in
            return total + item.key.price * Double(item.value)
        }
        self.total = String (format: "Total: %.2f %@", totalPrice * exchange, currency)
        self.updatedViewModels(rate: exchange)
    }
    
    func update(currencyId: String) {
        currencyService.exchangeRate(to: currencyId) { rate in
            if let exchange = rate {
                self.updateRate(exchange: exchange, currency: currencyId)
                DispatchQueue.main.async {
                    self.delegate?.refreshUI()
                }
            }
        }
    }
    
    func buy() {
        print("Buy Items")
    }
    
}
