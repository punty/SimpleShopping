//
//  CartViewController.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 18/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import UIKit

final class CartViewController: UIViewController, RefreshViewControllerType {
    
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    var viewModel: CartViewModel!
    fileprivate var pickerView: UIPickerView?
    
    fileprivate var dataSource: SingleSectionItemsDataSource<CartItemTableViewCell>? = nil
    fileprivate var pickerDelegate: CurrencyPickerDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupToolbar()
        dataSource = SingleSectionItemsDataSource<CartItemTableViewCell>()
        cartTableView.dataSource = dataSource
        currencyTextField.delegate = self
        title = viewModel.viewTitle
        //initalize all the property with default value
        viewModel.initialize()
        payButton.isEnabled = viewModel.canBuy
    }
    
    private func setupToolbar() {
        let toolBar = UIToolbar()
        toolBar.isTranslucent = true
        let item = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([space, item], animated: false)
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        currencyTextField.inputAccessoryView = toolBar
    }
    
    fileprivate func setupPickerView(currencies:[Currency]) {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        pickerDelegate = CurrencyPickerDataSource(currencies: currencies, callback: { item in
            self.currencyTextField.text = item.name
        })
        picker.delegate = pickerDelegate
        picker.dataSource = pickerDelegate
        currencyTextField.inputView = picker
        pickerView = picker
    }
    
    @objc func donePressed() {
        currencyTextField.resignFirstResponder()
        guard let picker = pickerView, let dataSource = pickerDelegate else {return}
        let selectedRow = picker.selectedRow(inComponent: 0)
        if let currency = dataSource.currency(at: selectedRow) {
            viewModel.update(currencyId: currency.id)
        }
        
    }

    @IBAction func payButtonPressed(_ sender: UIButton) {
       viewModel.buy()
       let _ = navigationController?.popViewController(animated: true)
    }
    
    fileprivate func updateTextField () {
        if let index = pickerDelegate?.index(ofId: viewModel.currency) {
            if let currency = pickerDelegate?.currency(at: index) {
                currencyTextField.text = currency.name
            }
        }
    }
    
    func refreshUI() {
        if let cellViewModels = viewModel.viewModels {
            dataSource?.items = cellViewModels
        }
        cartTableView.reloadData()
        totalLabel.text = viewModel.total
        updateTextField()
    }
}

extension CartViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let picker = pickerView else {return true}
        guard let pickerData = pickerDelegate else {return true}
        guard let text = textField.text else {return true}
        if let index = pickerData.index(of: text) {
            picker.selectRow(index, inComponent: 0, animated: false)
        }
        return true
    }
}

extension CartViewController: InitializableViewController {
  
    func initializeUI() {
        guard let cellViewModels = viewModel.viewModels,
              let currencies = viewModel.currencies else {
              print("No network")
              let _ = self.navigationController?.popViewController(animated: true)
              return
        }
        dataSource?.items = cellViewModels
        setupPickerView(currencies: currencies)
        updateTextField()
        cartTableView.reloadData()
        totalLabel.text = viewModel.total
        payButton.isEnabled = viewModel.canBuy
    }
}



