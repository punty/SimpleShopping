//
//  ItemModel.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 16/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation

struct Item: Hashable {
    var itemId: String
    var itemName: String
    var price: Double
    
    var hashValue: Int {
        return self.itemId.hashValue ^ self.itemName.hashValue ^ self.price.hashValue
    }
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.itemId == rhs.itemId
    }
}






