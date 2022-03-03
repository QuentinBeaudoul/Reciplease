//
//  UIViewcontroller.swift
//  RExtension
//
//  Created by Quentin on 03/03/2022.
//

import UIKit

public extension UIViewController {
    
    class func makeFromStoryboard(_ storyboardName: String? = nil, withTitle title: String? = nil, in bundle: Bundle? = nil) -> UIViewController {
        let vc = UIStoryboard(name: storyboardName ?? String(describing: self).replacingOccurrences(of: "ViewController", with: ""),
                              bundle: bundle).instantiateViewController(withIdentifier: String(describing: self))
        vc.title = title
        return vc
    }

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
