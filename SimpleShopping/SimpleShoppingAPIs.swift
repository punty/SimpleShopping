//
//  SimpleShoppingAPIs.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 20/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation
import SimpleNetwork

//Every case is a different API Endpoint
enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://apilayer.net/api/"
    static let apiToken = "01203e9b1210769adc49258f45278f25"
    
    case currencyList
    case live(surce: String)
    case liveTo(surce: String, currency:String)
    
    func asURLRequest() -> URLRequest? {
        
        //set path and parameter for all the API calls
        let result: (path: String, parameters: [String:String]?) = {
            switch self {
            case .currencyList:
                return ("list", ["access_key":Router.apiToken])
            case .live(let source):
                //Currently not used
                return ("live", ["access_key":Router.apiToken, "source":source])
            case .liveTo(let source, let currency):
                return ("live", ["access_key":Router.apiToken, "source":source, "currencies":currency])
            }
        }()
        
        let path = Router.baseURLString + result.path
        if let urlComponent = NSURLComponents(string: path) {
            var queries:[URLQueryItem] = []
            result.parameters?.forEach() {
                item in
                queries.append(URLQueryItem(name: item.key, value: item.value))
            }
            urlComponent.queryItems = queries
            
            if let reqURL = urlComponent.url {
                let request = URLRequest(url: reqURL)
                return request
            }
        }
        return nil
    }
}
