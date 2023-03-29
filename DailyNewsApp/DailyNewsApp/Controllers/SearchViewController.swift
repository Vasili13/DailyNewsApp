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
    
    lazy var lbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Here you can find articles"
        lbl.font = .systemFont(ofSize: 23, weight: .medium)
        lbl.textColor = .systemGray4
        return lbl
    }()
    
    private let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.addSubview(searchTableView)
        view.addSubview(lbl)
        createSearchBar()
        updateViewConstraints()
    }
    
        func createSearchBar() {
            navigationItem.searchController = search
            navigationItem.hidesSearchBarWhenScrolling = false
            search.searchBar.delegate = self
        }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        searchTableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        lbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
                    
                    if self?.viewModel == nil {
                        self?.lbl.isHidden = true
                    } else {
                        self?.lbl.text = "Sorry... Nothing found :("
                    }
                    
                    self?.searchTableView.reloadData()
                }
            case .failure(let error):
                print(error )
            }
        }
    }
    
    deinit {
        print("deinit search")
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
