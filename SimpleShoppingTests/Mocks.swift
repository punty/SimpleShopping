//
//  Mocks.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 20/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation

@testable import SimpleShopping
@testable import SimpleNetwork


class NetworkMock: ServiceClientType {
    
    var response:JSONInitializable?
    
    func get<T:JSONInitializable>(api: URLRequestConvertible, completion:@escaping (Result<T>)->()) {
        guard let r = response as? T else {
            completion(Result<T>.failure(.networkError))
            return
        }
        completion(Result.success(r))
    }
}

class UserServiceMock: UserServiceType {
    var currentUser = User(name: "UserName", id: "999", cart: [])
    func addToCart(item: Item) {}
    func removeFromCart(item: Item) {}
}




