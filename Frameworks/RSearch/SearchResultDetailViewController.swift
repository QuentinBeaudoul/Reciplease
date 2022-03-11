//
//  SearchResultDetailViewController.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import UIKit

class SearchResultDetailViewController: UIViewController {

    let viewModel = SearchResultDetailViewModel()

    @IBOutlet weak var recipeTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        recipeTitleLabel.text = viewModel.getTitle()
    }
}
