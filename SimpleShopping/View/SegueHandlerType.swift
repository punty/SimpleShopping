//
//  SegueHandlerType.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 16/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import UIKit

protocol RefreshViewControllerType: class {
    func refreshUI()
}

protocol InitializableViewController: class {
    func initializeUI()
}

protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else { fatalError("Unknown segue: \(segue))") }
        return segueIdentifier
    }
    
    func performSegue(segueIdentifier: SegueIdentifier, sender: AnyObject? = nil) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
}
