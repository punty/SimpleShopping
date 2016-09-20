//
//  CurrencyPickerDatasource.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 20/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import  UIKit

final class CurrencyPickerDataSource:NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let currencies: [Currency]
    
    var callback:(Currency) ->()
    
    init(currencies: [Currency], callback:@escaping (Currency)->()) {
        self.currencies = currencies
        self.callback = callback
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback(currencies[row])
    }
    
    func currency(at: Int) -> Currency? {
        if at >= 0 && at < currencies.count {
            return currencies[at]
        }
        return nil
    }
    
    func index(of: String) -> Int? {
        return currencies.index() {
            $0.name == of
        }
    }
    
    func index(ofId: String) -> Int? {
        return currencies.index() {
            $0.id == ofId
        }
    }
}
