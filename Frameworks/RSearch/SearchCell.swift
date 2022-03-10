//
//  SearchCell.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var ingredientLabel: UILabel!

    func fillView(text: String) {
        ingredientLabel.text = "- \(text)"
    }
}
