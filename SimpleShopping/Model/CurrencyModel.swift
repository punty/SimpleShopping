//
//  CurrencyModel.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 19/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation
import SimpleNetwork

struct Currency {
    var id: String
    var name: String
    
}

//This struct is just a wrapper around the dictionary that contains the currencies
struct Currencies: JSONInitializable {
    
    var list:[Currency]
    
    init(json: [String : Any]) throws {
       guard let currencies = json["currencies"] as? [String:String] else {
            throw ServiceError.missing("currencies")
        }
        list = currencies.map {
            return Currency(id: $0.key, name: $0.value)
        }
    }
    
    init (list: [Currency]) {
        self.list = list
    }
}


//This struct is just a wrapper around the dictionary that contains the exchange rates
struct Convert: JSONInitializable {
    
    var quotes: [String:Double]
    
    init(json: [String : Any]) throws {
        guard let quotesDictionary = json["quotes"] as? [String:Double] else {
            throw ServiceError.missing("quotes")
        }
        quotes = quotesDictionary
    }
    
    init (quotes: [String:Double]) {
        self.quotes = quotes
    }
}
