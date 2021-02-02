//
//  CustomButton.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import UIKit

open class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.setTitleColor(.white, for: .normal)
        
    }
}

