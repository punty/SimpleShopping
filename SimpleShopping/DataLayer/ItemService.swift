//
//  ItemService.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 19/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation

//Used for dependency injection (better testability)
protocol ItemsServiceType {
    var items: [Item] {get}
}

//#Simplification!
//this is just a placeholder, in a real app we would use some proper way
//To retrieve the list of items
final class ItemsService: ItemsServiceType {
    
    //#Simplification!
    ///Return the available items
    var items = [
        Item(itemId: "0", itemName: "Peas", price: 0.95),
        Item(itemId: "1", itemName: "Eggs", price: 2.1),
        Item(itemId: "2", itemName: "Milk", price: 1.30),
        Item(itemId: "3", itemName: "Beans", price: 0.73)
    ]
    
}
