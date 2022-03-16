//
//  SearchResultViewController.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import UIKit

class SearchResultViewController: UIViewController {

    let viewModel = SearchResultViewModel()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Recipes"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SearchResultCell.getCellIdentifier(),
                                 bundle: Bundle(for: Self.self)),
                           forCellReuseIdentifier: SearchResultCell.getCellIdentifier())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.displayFavorites {
            viewModel.reloadFavorite { [self] result in
                switch result {

                case .success(let isGood):
                    if isGood {
                        tableView.reloadData()
                    }
                case .failure(let error):
                    UIAlertController.showAlert(title: "Error", message: error.localizedDescription, on: self)
                }
            }
        }
    }

    private func insertRow(oldNumberOfItems: Int) {
        tableView.performBatchUpdates {
            var indexPaths = [IndexPath]()
            for index in oldNumberOfItems...viewModel.recipes.count - 1 {
                indexPaths.append(IndexPath(row: index, section: 0))
            }

            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultCell.getCellIdentifier(),
            for: indexPath) as? SearchResultCell else { return UITableViewCell() }

        cell.fillView(recipe: viewModel.getRecipe(at: indexPath))

        return cell
    }

}

extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.getRecipe(at: indexPath)

        guard let detailVC = SearchResultDetailViewController
                .makeFromStoryboard(in: Bundle(for: Self.self)) as? SearchResultDetailViewController else { return }

        detailVC.viewModel.loadData(recipe: recipe)

        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !viewModel.displayFavorites else { return }

        let oldNumberOfItems = viewModel.getNumberOfItems()
        if indexPath.row == oldNumberOfItems - 5 && viewModel.hasNextPage() {
            tableView.tableFooterView?.isHidden = false

            viewModel.fetchNextPage { [self] result in
                switch result {

                case .failure(let error):
                    print(error)
                    UIAlertController.showAlert(title: "It's a free plan",
                                                message: "Api is a bit sensitive. Don't hit her too much 🥺",
                                                on: self)
                default:
                    insertRow(oldNumberOfItems: oldNumberOfItems)
                }
            }
        }
    }
}
