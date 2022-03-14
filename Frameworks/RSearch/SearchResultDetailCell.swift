//
//  SearchResultDetailCell.swift
//  RSearch
//
//  Created by Quentin on 14/03/2022.
//

import UIKit

class SearchResultDetailCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    func fillView(ingredient: String) {
        label.text = "- \(ingredient)"
    }
}
