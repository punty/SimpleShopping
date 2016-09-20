//
//  CartCellViewModel.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 19/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation

struct CartCellViewModel {
    
    var name: String
    var price: String
    var quantity: String
    
    init(name: String, price: Double, quantity: Int, currency: String) {
        self.name = name
        self.price = String(format: "%.2f", price) + " " + currency
        self.quantity =  " x " + String(quantity)
    }
}
