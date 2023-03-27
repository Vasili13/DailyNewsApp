//
//  SearchViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 26.03.23.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var searchedArticles = [Article]()
    var viewModel = [SearchTableViewCellViewModel]()

    lazy var searchTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.key)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchTableView)
        createSearchBar()
        updateViewConstraints()
    }
    
        func createSearchBar() {
            navigationItem.searchController = search
            search.searchBar.delegate = self
        }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        searchTableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }

        ApiCaller.shared.search(with: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.searchedArticles = articles
                self?.viewModel = articles.compactMap({
                    SearchTableViewCellViewModel(title: $0.title ?? "", subtitle: $0.description ?? "No descr", imageURL: URL(string: $0.urlToImage ?? ""))
                })

                DispatchQueue.main.async {
                    self?.searchTableView.reloadData()
                }
            case .failure(let error):
                print(error )
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.key, for: indexPath) as? SearchTableViewCell else { fatalError() }
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
