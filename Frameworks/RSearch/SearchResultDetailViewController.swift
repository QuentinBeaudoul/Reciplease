//
//  SearchResultDetailViewController.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import UIKit
import Kingfisher
import RExtension

class SearchResultDetailViewController: UIViewController {

    let viewModel = SearchResultDetailViewModel()

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var timeToDoView: UIView!
    @IBOutlet weak var timeToDoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var favButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = viewModel.getTitle()
        recipeImageView.kf.setImage(with: viewModel.getImageUrl(),
                                    placeholder: R.image.icone(compatibleWith: traitCollection))

        timeToDoView.isHidden = !viewModel.hasTimeToDo()
        timeToDoLabel.text = viewModel.getTimeToDo()

        favButton.setImage(viewModel.isFavorite() ?
                           UIImage(systemName: "star.fill") :
                            UIImage(systemName: "star"), for: .normal)

        tableView.dataSource = self
        tableView.register(UINib(nibName: SearchResultDetailCell.getCellIdentifier(),
                                 bundle: Bundle(for: Self.self)),
                           forCellReuseIdentifier: SearchResultDetailCell.getCellIdentifier())
        tableViewHeightConstraint.constant = CGFloat(viewModel.getNumberOfItems() * 40)
    }

    @IBAction func favButtonTapped() {
        var result = false
        if viewModel.isFavorite() {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
            result = viewModel.dropRecipe()
        } else {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            result = viewModel.addRecipe()
        }

        if !result {
            UIAlertController.showAlert(title: "❗️", message: "Something went wrong", on: self)
        }
    }
}

extension SearchResultDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultDetailCell.getCellIdentifier(),
                                                       for: indexPath) as? SearchResultDetailCell
        else { return UITableViewCell() }

        cell.fillView(ingredient: viewModel.getIngredient(at: indexPath))

        return cell
    }
}
