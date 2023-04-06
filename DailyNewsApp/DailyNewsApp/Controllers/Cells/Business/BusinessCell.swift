//
//  BusinessCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 24.03.23.
//

import SnapKit
import UIKit

class BusinessCell: UICollectionViewCell {
    var delegate: LoadSafariProtocol?
    var articles = [Article]()
    var viewModels = [BusinessTableViewCellViewModel]()
    
    lazy var businessTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(BusinessTableViewCell.self, forCellReuseIdentifier: BusinessTableViewCell.key)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fetchInfo()
        
        addSubview(businessTableView)
        
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        businessTableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchInfo() {
        NetworkService.fetchBusinessArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap {
                    BusinessTableViewCellViewModel(title: $0.title ?? "", subtitle: $0.description ?? "There is no description here", imageURL: URL(string: $0.urlToImage ?? ""), url: $0.url ?? "")
                }

                DispatchQueue.main.async {
                    self?.businessTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension BusinessCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BusinessTableViewCell.key, for: indexPath) as? BusinessTableViewCell else { fatalError() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: viewModels[indexPath.row].url ?? "") else { return }
        delegate?.loadNewScreen(url: url)
    }
}