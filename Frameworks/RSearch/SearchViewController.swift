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
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!

    private var loadingScreen: LoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLoadingScreen()
        headerView.delegate = self

        editText.delegate = self
        hideKeyboardWhenTappedAround()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SearchCell.getCellIdentifier(),
                                 bundle: Bundle(for: Self.self)),
                           forCellReuseIdentifier: SearchCell.getCellIdentifier())

        updateUI()
    }

    private func setupLoadingScreen() {
        loadingScreen = LoadingView()
        loadingScreen?.isHidden = true

        if let window = UIApplication.keyWindow, let loadingScreen = loadingScreen {
            loadingScreen.frame = window.frame
            window.addSubview(loadingScreen)
        }
    }

    private func updateUI() {
        let numberOfItems = viewModel.getNumberOfItems()
        numberOfItems > 0 ? headerView.enableButton() : headerView.disableButton()
        searchButton.isEnabled = numberOfItems > 0 ? true : false
        hideErrorView()
    }

    private func insertRow() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: viewModel.getNumberOfItems() - 1, section: 0)], with: .automatic)
        tableView.endUpdates()
        updateUI()
    }

    private func showErrorView(error: String) {
        errorLabel.text = error

        UIView.animate(withDuration: 0.3) { [self] in
            errorView.isHidden = false
        }
    }

    private func hideErrorView() {
        UIView.animate(withDuration: 0.3) { [self] in
            errorView.isHidden = true
        }
    }

    @IBAction func addCriteriaTapped() {

        guard var newElement = editText.text else {
            showErrorView(error: "Something went wrong...")
            return
        }

        if newElement.count <= 0 {
            showErrorView(error: "You cannot add a empty keyword 😬")
            addCriteriaButton.shake()
            return
        }

        newElement = newElement.trimmingCharacters(in: .whitespaces)

        if !viewModel.isKeywordValid(newElement) {
            showErrorView(error: "You cannot use special characters in your keyword 😶‍🌫️")
            addCriteriaButton.shake()
            return
        }

        viewModel.add(newElement: newElement)
        editText.text = ""
        insertRow()
    }

    @IBAction func searchForRecipeTapped() {
        loadingScreen?.show()
        viewModel.fetchRecipes(keywords: viewModel.getKeywordsFormatted()) { [self] result in
            loadingScreen?.hide()
            switch result {
            case .success(let container):
                guard let resultVC = SearchResultViewController.makeFromStoryboard(in: Bundle(for: Self.self))
                        as? SearchResultViewController else { return }

                resultVC.viewModel.loadData(container: container)

                navigationController?.pushViewController(resultVC, animated: true)
            case .failure(let error):
                print(error)
                UIAlertController.showAlert(title: "No result found",
                                            message: "Are you sure you have this in your fridge ? 🤨",
                                            on: self)
            }
        }
    }

    @IBAction func errorViewTapped() {
        hideErrorView()
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

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [self] _, _, completion in
            viewModel.remove(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .right)
            updateUI()
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")?
            .withTintColor(R.color.onSecondary(compatibleWith: traitCollection) ?? .white)
        deleteAction.backgroundColor = R.color.secondary(compatibleWith: traitCollection)

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension SearchViewController: HeaderDelegate {
    func onClearButtonTapped() {

        viewModel.keywords.forEach({ _ in
            let indexPath = IndexPath(row: 0, section: 0)
            viewModel.remove(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .right)
        })

        updateUI()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addCriteriaTapped()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideErrorView()
    }
}
