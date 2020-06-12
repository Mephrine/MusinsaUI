//
//  GoodsRankingTabItemCell.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) GoodsRankingTabItemCell.swift
 - Author: Mephrine
 - Date: 20.06.10
 - Note: 상품 랭킹 탭 아이템 Cell
*/
class GoodsRankingTabItemCell: BaseCollectionViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(tabBarHeight / 2)
    }
    
    func configure(model: GoodsRankingTabItemModel) {
        self.lbTitle.text = model.tabNm
        
        if model.isSelected {
            self.backgroundColor = .blue
            self.lbTitle.textColor = .white
        } else {
            self.backgroundColor = UIColor(hex: 0xf1f1f1)
            self.lbTitle.textColor = UIColor(hex: 0x8e8e8e)
        }
    }
    

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout()
        layoutIfNeeded()

        // 최신으로 반영된 상태의 contentView의 사이즈로 적용.
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame

        return layoutAttributes
    }
}

