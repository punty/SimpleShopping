//
//  CurrencyService.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 19/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import Foundation
import SimpleNetwork

//Used for dependency injection (better testability)
protocol CurrencyServiceType {
    func currencyList(completion: @escaping ([Currency]?)->())
    func exchangeRate (to: String, completion: @escaping (Double?)->())
    var currency: String {get set}
    
}

final class CurrencyService: CurrencyServiceType {
    
    var currencies: [Currency]?
    
    var serviceClient: ServiceClientType
    
    init (serviceClient: ServiceClientType) {
        self.serviceClient = serviceClient
        if let listDictionary = UserDefaults.standard.object(forKey: "currencies") as? [[String : String]] {
            currencies = listDictionary.flatMap() { item in
                return Currency (id: item.keys.first!, name: item.values.first!)
            }
        }
    }
    
    ///return a list of currencies
    func currencyList(completion: @escaping ([Currency]?)->()) {
        if currencies != nil {
            completion(currencies)
        } else {
            updateCurrencyList(completion: completion)
        }
    }
    
    ///Calculate the exchange rate from USD to the selected currency.
    //It always hits the API so we always get the latest
    //exhange rate. I optimised this method by requesting only the selected currency
    func exchangeRate (to: String, completion: @escaping (Double?)->()) {
        serviceClient.get(api: Router.liveTo(surce: "USD", currency: to)) {
            (result: Result<Convert>) in
            switch result {
                case .success(let quotes):
                    if let rate = quotes.quotes["USD"+to]  {
                        completion(rate)
                        return
                    }
                case .failure:
                    completion(nil)
            }
        }
    }
    
   ///Update the currency list from API
   func updateCurrencyList(completion: @escaping ([Currency]?)->()) {
    serviceClient.get(api: Router.currencyList) { (result: Result<Currencies>) in
        switch result {
            case .success(let currencyList):
                self.persistList(list: currencyList)
                completion(currencyList.list)
            case .failure:
                break
            }
        }
    }
    
    ///Persist the list of currencies. 
    private func persistList(list: Currencies?) {
        //need to transform the array
        self.currencies = list?.list
        if list != nil {
            let p = list?.list.map {
                return [$0.id:$0.name]
            }
            UserDefaults.standard.set(p, forKey: "currencies")
        }
        
    }
    
    var currency: String {
        get {
            if let value =  UserDefaults.standard.string(forKey: "currency") {
                return value
            } else {
                return "USD"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currency")
        }
    }
    
}
