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
}

