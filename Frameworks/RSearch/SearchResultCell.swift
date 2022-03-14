//
//  SearchResultCell.swift
//  RSearch
//
//  Created by Quentin on 11/03/2022.
//

import UIKit
import RStorage
import RExtension
import Kingfisher

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var timeToDoView: UIView!
    @IBOutlet weak var timeToDoLabel: UILabel!

    func fillView(recipe: Recipe) {

        let url = URL(string: recipe.imageUrl ?? "")
        recipeImageView.kf.setImage(with: url, placeholder: R.image.icone(compatibleWith: traitCollection))

        titleLabel.text = recipe.label
        ingredientsLabel.text = recipe.getIngredientsFormatted()

        if recipe.hasTimeToDo() {
            timeToDoLabel.text = recipe.getTimeToDo()
            timeToDoView.isHidden = false
        } else {
            timeToDoView.isHidden = true
        }

    }
}
