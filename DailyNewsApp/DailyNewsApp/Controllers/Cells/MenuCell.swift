//
//  MenuCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 21.03.23.
//

import Foundation
import UIKit

class MenuCell: UICollectionViewCell {
    
    lazy var categoryText: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? .blue : .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryText)
        updateConstraints()
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
