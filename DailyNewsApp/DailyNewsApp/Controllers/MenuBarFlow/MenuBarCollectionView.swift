//
//  MenuCollectionView.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 20.03.23.
//

import Foundation
import SnapKit
import UIKit

class MenuBarCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        collection.showsHorizontalScrollIndicator = false
        collection.selectItem(at: [0, 0], animated: true, scrollPosition: [])
        return collection
    }()
    
    private let cellID = "CellID"
    private let categoryName = ["Top", "Entertainment", "Business", "Health", "Science", "Sports", "Technology"]
    
    weak var viewController: MainViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(menuCollectionView)
        
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        menuCollectionView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    func scrollMenu(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        menuCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
        menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MenuCell {
            cell.layer.cornerRadius = 15
            cell.categoryText.text = categoryName[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        viewController?.scrollMenu(menuIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 130, height: 40)
    }
}
