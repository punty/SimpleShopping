//
//  ShoppingStepper.swift
//  SimpleShopping
//
//  Created by Francesco Puntillo on 16/09/2016.
//  Copyright © 2016 punty. All rights reserved.
//

import UIKit

// I didn't go into full details with the implementation of this class
// In order to make this view a real component requires much more work
// what I want to show with this approach is that I usually think of many way of reusing the code

protocol ShoppingStepperDelegate {
    func valueDidUpdate (stepper: ShoppingStepper, increase: Bool)
    
}

@IBDesignable
final class ShoppingStepper: UIView {
    
    var increaseButton: UIButton = {
        let increaseButton = UIButton(type: .custom)
        increaseButton.setTitle("+", for: .normal)
        increaseButton.setTitleColor(.white, for: .normal)
        increaseButton.setTitleColor(.gray, for: .disabled)
        increaseButton.backgroundColor = .green
        return increaseButton
    }()
    
    var decreaseButton: UIButton = {
        let decreaseButton = UIButton(type: .custom)
        decreaseButton.setTitleColor(.white, for: .normal)
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.setTitleColor(.gray, for: .disabled)
        decreaseButton.backgroundColor = .red
        return decreaseButton
    }()
    
    var valueLabel: UILabel = {
        let valueLabel = UILabel(frame: CGRect.zero)
        valueLabel.backgroundColor = .white
        valueLabel.textAlignment = .center
        return valueLabel
    }()
    
    private let maxButtonWidth:CGFloat = 44.0
    
    var value = 0
    var minValue = 0
    var maxValue = 10
    
    public let defaultWidth = 140.0
    public let defaultHeight = 44.0
    
    var delegate: ShoppingStepperDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public func prepareForInterfaceBuilder() {
        commonInit()
    }
    
    func commonInit() {
        addSubview(decreaseButton)
        addSubview(valueLabel)
        addSubview(increaseButton)
        increaseButton.addTarget(self, action: #selector(increase), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decrease), for: .touchUpInside)
        updateValueLabel()
    }
    
    
    override func layoutSubviews() {
        
        let sliceWidth = bounds.width / 3
        let sliceHeight = bounds.height
        
        let buttonsWidth = min(sliceWidth, maxButtonWidth)
        let labelWidth = bounds.width - (2 * buttonsWidth)
        
        // Set frames
        decreaseButton.frame = CGRect(x: 0, y: 0, width: buttonsWidth, height: sliceHeight)
        valueLabel.frame = CGRect(x: buttonsWidth, y: 0, width: labelWidth, height: sliceHeight)
        increaseButton.frame = CGRect(x: labelWidth + buttonsWidth, y: 0, width: buttonsWidth, height: sliceHeight)
    }
    
    @objc func increase() {
        value = min (maxValue, value + 1)
        updateValueLabel()
        delegate?.valueDidUpdate(stepper: self, increase: true)
    }
    
    @objc func decrease() {
        value = max (minValue, value - 1)
        updateValueLabel()
        delegate?.valueDidUpdate(stepper: self, increase: false)
    }
    
    func updateValueLabel () {
        valueLabel.text = String(value)
        increaseButton.isEnabled = value < maxValue
        decreaseButton.isEnabled = value > minValue
    }
}
