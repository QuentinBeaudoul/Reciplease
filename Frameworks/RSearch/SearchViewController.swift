//
//  SearchViewController.swift
//  RSearch
//
//  Created by Quentin on 03/03/2022.
//

import UIKit
import RExtension

class SearchViewController: UIViewController {

    let viewModel = SearchViewModel()

    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var addCriteriaButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerView.delegate = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SearchCell.getCellIdentifier(),
                                 bundle: Bundle(for: Self.self)),
                           forCellReuseIdentifier: SearchCell.getCellIdentifier())

        updateUI()
    }

    private func updateUI() {
        let numberOfItems = viewModel.getNumberOfItems()
        numberOfItems > 0 ? headerView.enableButton() : headerView.disableButton()
        searchButton.isEnabled = numberOfItems > 0 ? true : false
        tableView.reloadData()
    }

    @IBAction func addCriteriaTapped() {

        guard let newElement = editText.text, newElement.count > 0 else {
            addCriteriaButton.shake()
            return
        }

        viewModel.add(newElement: newElement)
        editText.text = ""
        updateUI()
    }

    @IBAction func searchForRecipeTapped() {

    }
}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.getCellIdentifier(),
                                                       for: indexPath) as? SearchCell else { return UITableViewCell() }

        cell.fillView(text: viewModel.getKeyword(at: indexPath))

        return cell
    }
}

extension SearchViewController: UITableViewDelegate {

}

extension SearchViewController: HeaderDelegate {
    func onClearButtonTapped() {
        viewModel.removeAll()
        updateUI()
    }
}
