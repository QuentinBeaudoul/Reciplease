//
//  SearchViewController.swift
//  RSearch
//
//  Created by Quentin on 03/03/2022.
//

import UIKit

class SearchViewController: UIViewController {

    let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.fetchRecipes(keywords: "Salad") { result in
            switch result {

            case .failure(let error):
                print(error)
            default:
                print("Success")
            }
        }
    }
}
