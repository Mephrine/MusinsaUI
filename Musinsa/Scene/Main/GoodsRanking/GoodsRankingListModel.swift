//
//  GoodsRankingListModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct GoodsRankingListModel {
    let item: GoodsRanking
    var titleNm: String {
        return ""
    }
    
    init(item: GoodsRanking) {
        self.item = item
    }
}
