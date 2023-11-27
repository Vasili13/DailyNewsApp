//
//  MenuCell.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 21.03.23.
//

import Foundation
import UIKit

final class MenuCell: UICollectionViewCell {
    lazy var categoryText: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17, weight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override var isSelected: Bool {
        didSet {
            categoryText.textColor = self.isSelected ? UIColor.white : UIColor.black
            backgroundColor = self.isSelected ? .systemBlue : .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryText)
        updateConstraints()
    }
    
    @available(*, unavailable)
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
