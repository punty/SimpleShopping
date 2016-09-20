//
//  UserServiceTests.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 20/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import XCTest
@testable import SimpleShopping

class UserServiceTests: XCTestCase {
    
    var service: UserService!
    
    override func setUp() {
        super.setUp()
        service = UserService()
    }
    
    func testCart() {
        let item1 = Item(itemId: "1", itemName: "1", price: 1)
        let item2 = Item(itemId: "2", itemName: "2", price: 1)
        let item3 = Item(itemId: "3", itemName: "2", price: 1)
        service.addToCart(item: item1)
        service.addToCart(item: item2)
        service.addToCart(item: item3)
        XCTAssert(service.currentUser.cart.count == 3)
        service.removeFromCart(item: item1)
        XCTAssert(service.currentUser.cart.count == 2)
        service.removeFromCart(item: item2)
        XCTAssert(service.currentUser.cart.count == 1)
        service.removeFromCart(item: item2)
        XCTAssert(service.currentUser.cart.count == 1)
        service.removeFromCart(item: item3)
        XCTAssert(service.currentUser.cart.count == 0)
    }
}
