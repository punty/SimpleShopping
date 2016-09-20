//
//  CartViewModelTest.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 20/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import XCTest

@testable import SimpleShopping

class CartViewModelTest: XCTestCase {
    
    class CurrencyServiceMock: CurrencyServiceType {
        
        func currencyList(completion: @escaping ([Currency]?)->()) {
            let currencyArray = [
                Currency(id: "USD", name: "Dollar"),
                Currency (id: "EUR", name: "Euro")
            ]
            
            completion(currencyArray)
        }
        func exchangeRate (to: String, completion: @escaping (Double?)->()) {
            completion(12.0)
        }
        var currency: String = "USD"
    }
    
//This is now very easy to test
    func testUpdate() {
        let viewModel = CartViewModel(userService: UserServiceMock(), currencyService: CurrencyServiceMock())
        XCTAssert(viewModel.currencies == nil)
        XCTAssert(viewModel.exchangeRate == nil)
        viewModel.update(currencyId: "EUR")
        XCTAssert(viewModel.currency == "EUR")
        XCTAssert(viewModel.exchangeRate == 12.0)
    }
    
    
    
}
