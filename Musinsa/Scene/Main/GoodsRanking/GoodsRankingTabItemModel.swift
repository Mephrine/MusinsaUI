//
//  GoodsRankingTabItemModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

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
