//
//  SimpleShoppingTests.swift
//  SimpleShoppingTests
//
//  Created by Francesco Puntillo on 16/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import XCTest
@testable import SimpleShopping

class SimpleShoppingTests: XCTestCase {
    
    class ItemServiceMock: ItemsServiceType {
        var items = [
            Item(itemId: "0", itemName: "Peas", price: 0.95),
            Item(itemId: "1", itemName: "Eggs", price: 2.1),
            Item(itemId: "2", itemName: "Milk", price: 1.30),
            Item(itemId: "3", itemName: "Beans", price: 0.73)
        ]
    }
    
    func testAddToCart() {
        let shoppingViewModel = ShoppingViewModel(user: UserServiceMock(), items: ItemServiceMock())
        let viewModels = shoppingViewModel.viewModels
        XCTAssert(viewModels.count == 4)
        XCTAssert(viewModels[0].text == "Beans")
        XCTAssert(viewModels[1].text == "Eggs")
        XCTAssert(viewModels[2].text == "Milk")
        XCTAssert(viewModels[3].text == "Peas")
    }
    
    func testCells() {
        let shoppingViewModel = ShoppingViewModel(user: UserServiceMock(), items: ItemServiceMock())
        let viewModels = shoppingViewModel.viewModels
        XCTAssert(viewModels.count == 4)
        XCTAssert(viewModels[0].text == "Beans")
        XCTAssert(viewModels[1].text == "Eggs")
        XCTAssert(viewModels[2].text == "Milk")
        XCTAssert(viewModels[3].text == "Peas")
    }
}
