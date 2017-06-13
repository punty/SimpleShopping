//
//  NetworkService.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 18/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation

public enum Result<T: JSONInitializable> {
    case success(T)
    case failure(ServiceError)
}

//Something that can become use as URLRequest
public protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest?
}


//Describe network parsing and serialising error
public enum ServiceError: Error {
    case jsonCreationError
    case parsingError
    case networkError
    case missing(String)
    case invalid(String, Any)
}

//Describe anything that can be initialised from a json dictionary
public protocol JSONInitializable {
    init (json: [String:Any]) throws
}

public protocol ServiceClientType {
    func get<T:JSONInitializable>(api: URLRequestConvertible, completion:@escaping (Result<T>)->())
}

//Simple class used to get json from the network, parse and return the parsed object or the generated error
//I am using generic so this class will return any JSONInitializable in this way I can improve code reuse
public final class ServiceClient: ServiceClientType {
    
    public init() {
        //nothing to do
    }
    
    internal func handleSession<T:JSONInitializable>(data: Data?, response: URLResponse?, error: Error?, completion:@escaping (Result<T>)->()) {
        if let _ = error {
            completion(Result<T>.failure(.networkError))
            return
        }
        guard let jsonData = data else {
            completion(Result<T>.failure(.jsonCreationError))
            return
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else { completion(Result<T>.failure(.jsonCreationError))
                return
            }
            guard let success = json["success"] as? Bool else {
               completion(Result<T>.failure(.parsingError))
                return
            }
            if success {
                let obj = try T(json:json)
                completion(Result<T>.success(obj))
            } else {
               completion(Result<T>.failure(.networkError))
            }
        } catch  {
            completion(Result<T>.failure(.jsonCreationError))
            return
        }
    }
    
    public func get<T:JSONInitializable>(api: URLRequestConvertible, completion:@escaping (Result<T>)->()) {
        guard let request = api.asURLRequest() else {
            completion(Result<T>.failure(.networkError))
            return
        }
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            self.handleSession(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
}

