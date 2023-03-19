//
//  ViewController.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 12.03.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var horizontalNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(horizontalNewsCollectionView)
        
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        horizontalNewsCollectionView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

