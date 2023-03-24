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
