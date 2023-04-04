//
//  HealthCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 24.03.23.
//

import UIKit
import SnapKit

class HealthCell: UICollectionViewCell {
    
    var articles = [Article]()
    var viewModels = [HealthTableViewCellViewModel]()
    
    lazy var businessTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(HealthTableViewCell.self, forCellReuseIdentifier: HealthTableViewCell.key)
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
        ApiCaller.fetchHealthArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap {
                    HealthTableViewCellViewModel(title: $0.title ?? "", subtitle: $0.description ?? "There is no description here", imageURL: URL(string: $0.urlToImage ?? ""))
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

extension HealthCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HealthTableViewCell.key, for: indexPath) as? HealthTableViewCell else {fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
