//
//  ShoppingViewController.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 16/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import UIKit

final class ShoppingViewController: UIViewController, SegueHandlerType {
   
    typealias SegueIdentifier = Segues
    
    enum Segues: String {
        case checkout = "checkout"
        //Here would be easy to add more segues
    }
    
    @IBOutlet weak var showCartButton: UIBarButtonItem!
    @IBOutlet weak var itemsTable: UITableView!
    
    var viewModel: ShoppingViewModel!
    var dataSource: SingleSectionItemsDataSource<ItemTableViewCell>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        title = viewModel.viewTitle
        itemsTable.allowsSelection = false
        dataSource = SingleSectionItemsDataSource<ItemTableViewCell> (items: viewModel.viewModels)
        itemsTable.dataSource = dataSource
        refreshUI()
    }
    
    @IBAction func showCartPressed(_ sender: UIBarButtonItem) {
        performSegue(segueIdentifier: .checkout)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueIdentifier = segueIdentifierForSegue(segue: segue)
        switch segueIdentifier {
        case .checkout:
            guard let viewController = segue.destination as? CartViewController else {fatalError("Wrong View Controller")}
            viewController.viewModel = viewModel.cartViewModel()
        }
    }
    
}


extension ShoppingViewController: RefreshViewControllerType {
    //RefreshViewControllerType
    func refreshUI() {
        showCartButton.isEnabled = viewModel.showCart
    }
}
