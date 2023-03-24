//
//  EntertainmentCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 23.03.23.
//

import UIKit
import SnapKit

class EntertainmentCell: UICollectionViewCell {
    
    var articles = [Article]()
    var viewModels1 = [EntTableViewCellViewModel]()
    
    lazy var entTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(EntTableViewCell.self, forCellReuseIdentifier: EntTableViewCell.key)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fetchInfo()
        
        addSubview(entTableView)
        
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        entTableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchInfo() {
        ApiCaller.shared.fetchEntArticles { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels1 = articles.compactMap {
                    EntTableViewCellViewModel(title: $0.title ?? "", subtitle: $0.description ?? "No descr", imageURL: URL(string: $0.urlToImage ?? ""))
                }
                print(articles.count)

                DispatchQueue.main.async {
                    self?.entTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    private func fetchEntArticles() {
//        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?category=business&apiKey=56324ef9df0e4701a46b0b30ba67448b") else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print("ent error:\(error)")
//            }
//            guard let data = data else { return }
//
//            do {
//                self.articles = try JSONDecoder().decode([Article].self, from: data)
//                print(self.articles.count)
//                print("ENT")
//            } catch {
//                print(error)
//            }
//
//            DispatchQueue.main.async {
//                self.entTableView.reloadData()
//            }
//        }
//        task.resume()
//    }
}

extension EntertainmentCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EntTableViewCell.key, for: indexPath) as? EntTableViewCell else {fatalError()}
        cell.configure(with: viewModels1[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
