//
//  CategoryCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 22.03.23.
//

import UIKit
import SnapKit
import SafariServices

protocol MyProtocol {
    func loadNewScreen() -> Void
}

class CategoryCell: UICollectionViewCell {
    
    var delegate: MyProtocol!
    
    var articles = [Article]()
    
    var viewModels = [NewsTableViewCellViewModel]()
    
    lazy var newsTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.key)
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
    
    func fetchInfo() {
             ApiCaller.shared.fetchArticles { [weak self] result in
                 switch result {
                 case .success(let articles):
                     self?.articles = articles
                     self?.viewModels = articles.compactMap({
                         NewsTableViewCellViewModel(title: $0.title ?? "", subtitle: $0.description ?? "No descr", imageURL: URL(string: $0.urlToImage ?? ""))
                     })

                     DispatchQueue.main.async {
                         self?.newsTableView.reloadData()
                     }
                 case .failure(let error):
                     print(error )
                 }
             }
         }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        newsTableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.key, for: indexPath) as? NewsTableViewCell else { fatalError() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.loadNewScreen()
    }
}