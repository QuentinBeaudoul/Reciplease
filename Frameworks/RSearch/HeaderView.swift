//
//  HeaderView.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import Foundation
import LoadableViews

protocol HeaderDelegate: AnyObject {
    func onClearButtonTapped()
}

class HeaderView: LoadableView {

    @IBOutlet weak var button: UIButton!

    weak var delegate: HeaderDelegate?

    func enableButton() {
        button.isEnabled = true
    }

    func disableButton() {
        button.isEnabled = false
    }

    @IBAction func clearButtonTapped() {
        delegate?.onClearButtonTapped()
    }
}
