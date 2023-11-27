//
//  CategoryCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 22.03.23.
//

import SafariServices
import SnapKit
import UIKit

protocol LoadSafariProtocol {
    func loadNewScreen(url: URL) -> Void
}

final class TopHeadlinesCell: UICollectionViewCell {
    
    var delegate: LoadSafariProtocol?
    private var articlesList = [Article]()
    private var viewModel = [CustomTableViewCellViewModel]()
    
    lazy var newsTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.key)
        table.delegate = self
        table.dataSource = self
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(newsTableView)
        fetchInfo()
        updateConstraints()
    }
    
    private func fetchInfo() {
        NetworkService.fetchArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articlesList = articles
                self?.viewModel = articles.compactMap {
                    CustomTableViewCellViewModel(title: $0.title ?? "", subtitle: $0.description ?? "There is no description here", url: $0.url ?? "", imageURL: URL(string: $0.urlToImage ?? ""))
                }
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        newsTableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopHeadlinesCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.key, for: indexPath) as? CustomTableViewCell else { fatalError() }
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel[indexPath.row].url ?? "") else { return }
        delegate?.loadNewScreen(url: url)
    }
}
