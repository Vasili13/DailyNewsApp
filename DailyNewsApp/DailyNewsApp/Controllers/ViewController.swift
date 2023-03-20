//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 12.03.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var menuBar: MenuBarCollectionView = {
        let mb = MenuBarCollectionView()
        return mb
    }()
    
    lazy var horizontalNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .systemGray
        cv.isPagingEnabled = true
        return cv
    }()
    
    let cellId = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News"
        
        view.addSubview(menuBar)
        view.addSubview(horizontalNewsCollectionView)
        
        horizontalNewsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        updateViewConstraints()
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
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    
        let colors: [UIColor] = [.cyan,.brown,.clear,.lightText,.lightGray,.green,.magenta]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height )
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }
}

