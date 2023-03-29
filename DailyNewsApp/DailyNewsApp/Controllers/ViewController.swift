//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 12.03.23.
//

import UIKit
import SnapKit
import SafariServices

class ViewController: UIViewController {
    
    var article1 = [Article]()
    
    lazy var menuBar: MenuBarCollectionView = {
        let mb = MenuBarCollectionView()
        mb.viewController = self
        return mb
    }()
    
    lazy var horizontalNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        cv.register(EntertainmentCell.self, forCellWithReuseIdentifier: "entCell")
        cv.register(BusinessCell.self, forCellWithReuseIdentifier: "business")
        cv.register(HealthCell.self, forCellWithReuseIdentifier: "health")
        cv.register(ScienceCell.self, forCellWithReuseIdentifier: "science")
        cv.register(SportsCell.self, forCellWithReuseIdentifier: "sport")
        cv.register(TechnologyCell.self, forCellWithReuseIdentifier: "tech")
        
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let cellId = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateNavBar()
        view.addSubview(menuBar)
        view.addSubview(horizontalNewsCollectionView)
        updateViewConstraints()
    }
    
    func scrollMenu(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        horizontalNewsCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    private func configurateNavBar() {
        navigationItem.title = "News"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill.badge.plus"), style: .done, target: self, action: #selector(onButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle.fill"), style: .done, target: self, action: #selector(searchInfo))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        menuBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(100)
            make.height.equalTo(50)
        }
        
        horizontalNewsCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalTo(menuBar).offset(50)
        }
    }
    
    @objc func searchInfo() {
        guard let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func onButtonTapped() {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    deinit {
        print("deinit main")
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyProtocol {
    
    func loadNewScreen(url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.delegate = self
        
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "entCell", for: indexPath) as! EntertainmentCell
        } else if indexPath.item == 2 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "business", for: indexPath) as! BusinessCell
        } else if indexPath.item == 3 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "health", for: indexPath) as! HealthCell
        } else if indexPath.item == 4 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "science", for: indexPath) as! ScienceCell
        } else if indexPath.item == 5 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "sport", for: indexPath) as! SportsCell
        } else if indexPath.item == 6 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "tech", for: indexPath) as! TechnologyCell
        }
        
        print(indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height )
    }
}
