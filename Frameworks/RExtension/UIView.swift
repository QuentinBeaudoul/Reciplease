//
//  UIView.swift
//  RExtension
//
//  Created by Quentin on 03/03/2022.
//

import Foundation
import UIKit

@IBDesignable public extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return UIColor() }
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func shake(_ duration: Double = 1) {
        self.transform = CGAffineTransform(translationX: 3, y: 0)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
