//
//  UserService.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 16/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation

protocol UserServiceType {
    var currentUser: User {get}
    func addToCart(item: Item)
    func removeFromCart(item: Item)
}


//To retrieve the user, (no multiple users etc)
final class UserService: UserServiceType {

    //Return the current user
    var currentUser = User(name: "UserName", id: "999", cart: [])
    
    func addToCart(item: Item) {
        currentUser.cart.append(item)
    }
    
    func removeFromCart(item: Item) {
        let indexToRemove = currentUser.cart.index {$0.itemId == item.itemId}
        if let index = indexToRemove {
            currentUser.cart.remove(at: index)
        }
    }
   
}
