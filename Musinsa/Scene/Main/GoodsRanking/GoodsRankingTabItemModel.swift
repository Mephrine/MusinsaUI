//
//  GoodsRankingTabItemModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct GoodsRankingTabItemModel {
    let item: GoodsList
    let isSelected: Bool
    
    var tabNm: String {
        return item.name
    }
    
    init(item: GoodsList, isSelected: Bool) {
        self.item = item
        self.isSelected = isSelected
    }
}
