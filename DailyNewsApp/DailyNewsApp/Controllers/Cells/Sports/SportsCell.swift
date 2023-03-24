//
//  SportsCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 24.03.23.
//

import UIKit
import SnapKit

class SportsCell: UICollectionViewCell {
    
    var articles = [Article]()
    var viewModels = [SportsTableViewCellViewModel]()
    
    lazy var businessTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(SportsTableViewCell.self, forCellReuseIdentifier: SportsTableViewCell.key)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchInfo() {
        ApiCaller.shared.fetchSportArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap {
                    SportsTableViewCellViewModel(title: $0.title ?? "", subtitle: $0.description ?? "No descr", imageURL: URL(string: $0.urlToImage ?? ""))
                }
                print(articles.count)

                DispatchQueue.main.async {
                    self?.businessTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SportsCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SportsTableViewCell.key, for: indexPath) as? SportsTableViewCell else {fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
