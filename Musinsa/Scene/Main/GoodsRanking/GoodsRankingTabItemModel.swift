//
//  GoodsRankingTabItemModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) GoodsRankingTabItemModel.swift
 - Author: Mephrine
 - Date: 20.06.11
 - Note: GoodsRankingTabItem 뷰모델
*/
struct GoodsRankingTabItemModel {
    let tabNm: String
    let index: Int
    let isSelected: Bool
    
    init(tabNm: String, index: Int, isSelected: Bool) {
        self.tabNm = tabNm
        self.index = index
        self.isSelected = isSelected
    }
}
