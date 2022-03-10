//
//  UITableViewCell+Identifier.swift
//  RExtension
//
//  Created by Quentin on 10/03/2022.
//

import UIKit

public extension UITableViewCell {

    class func getCellIdentifier() -> String {
        return String(describing: self)
    }

}
