//
//  CurrencyServiceTests.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 20/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import XCTest

@testable import SimpleShopping
@testable import SimpleNetwork

class CurrencyServiceTests: XCTestCase {
    
    func testCurrency() {
        let network = NetworkMock()
        let service = CurrencyService(serviceClient: network)
        let currencyArray = [
            Currency(id: "USD", name: "Dollar"),
            Currency (id: "EUR", name: "Euro")
        ]
        
        let currencies = Currencies(list: currencyArray)
        network.response = currencies
        service.updateCurrencyList { _ in }
        XCTAssert(service.currencies?.count == 2)
    }
    
    
    func testParsingCurrencies() {
        let path = Bundle(for: type(of: self)).path(forResource: "currency", ofType: "json")
        let jsonURL = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: jsonURL)
        guard let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return
        }
        let currency = try? Currencies(json: json)
        XCTAssert(currency != nil)
        XCTAssert(currency?.list.count == 168)
        UserDefaults.standard.removeObject(forKey: "currencies")
    }
}
