//
//  CustomTextField.swift
//  Snap Chat Clone With Firebase
//
//  Created by Gil Aguilar on 2/7/17.
//  Copyright © 2017 Red Eye Dev. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius;
            layer.masksToBounds = cornerRadius > 0;
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth;
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor;
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor;
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            let attrString = attributedPlaceholder?.string != nil ?
            attributedPlaceholder!.string : "";
            
            let str = NSAttributedString(string: attrString, attributes: [NSForegroundColorAttributeName: placeholderColor!]);
                
            attributedPlaceholder = str;
        }
    }

} // class












