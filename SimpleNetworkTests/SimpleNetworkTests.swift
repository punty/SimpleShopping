//
//  SimpleNetworkTests.swift
//  SimpleNetworkTests
//
//  Created by Francesco Puntillo on 20/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import XCTest
@testable import SimpleNetwork

//Separeted Code is easy to test!!!
class SimpleNetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    class HelloTest: JSONInitializable {
        var hello:[String]
        required init(json: [String : Any]) throws {
            guard let h = json["Hello"] as? [String] else {
                throw ServiceError.missing("hello")
            }
            hello = h
        }
    }
    
    func testParsing() {
        let serviceClient = ServiceClient()
        let jsonString = "{\"success\":true,\"Hello\":[\"hi\",\"ciao\"]}"
        let data = jsonString.data(using: .utf8)
        serviceClient.handleSession(data: data, response: nil, error: nil) { (t: HelloTest?, nil) in
            XCTAssert(t?.hello.count == 2)
            XCTAssert(t?.hello[0] == "hi")
        }
    }
    
}
