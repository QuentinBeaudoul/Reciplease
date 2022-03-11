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

    private func insertRow() {
        tableView.performBatchUpdates {
            tableView.insertRows(at: [IndexPath(row: viewModel.getNumberOfItems() - 1, section: 0)], with: .automatic)
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
        guard !viewModel.isFavorite else { return }

        if indexPath.row == viewModel.getNumberOfItems() - 5 && viewModel.hasNextPage() {
            tableView.tableFooterView?.isHidden = false
            viewModel.fetchNextPage { [self] result in
                switch result {

                case .success():
                    insertRow()
                case .failure(let error):
                    print(error)
                    // TODO: Display Alert
                }
            }
        }
    }
}
