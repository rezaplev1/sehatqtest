//
//  CustomTextField.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import UIKit

@IBDesignable
open class PrimaryTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
    
    func setup() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.0
        self.borderStyle = .none
        self.layer.masksToBounds = false
        self.clearButtonMode = .whileEditing
        
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}

