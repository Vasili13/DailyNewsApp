//
//  MenuCollectionView.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 20.03.23.
//

import UIKit
import Foundation
import SnapKit

class MenuBarCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
        collection.isPagingEnabled = true
        return collection
    }()
    
    private let cellID = "CellID"
    private let categoryName = ["Top", "Entertainment", "Business", "Health", "Science", "Sports", "Technology"]
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuCell
        cell.categoryText.text = categoryName[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 
    }
    
}

class MenuCell: UICollectionViewCell {
    
    lazy var categoryText: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryText)
        updateConstraints()
    }
    
    override var isHighlighted: Bool {
        didSet {
            categoryText.textColor = isHighlighted ? UIColor.magenta : UIColor.green
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        categoryText.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
}
