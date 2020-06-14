//
//  GoodsRankingListItemModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/12.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) GoodsRankingListItemModel.swift
 - Author: Mephrine
 - Date: 20.06.12
 - Note: GoodsRankingListItem 뷰모델
*/
struct GoodsRankingListItemModel {
    let item: GoodsListItem
    
    var name: String {
        return item.name
    }
    
    var imageURL: URL? {
        if let url = URL(string: item.image) {
            return url
        }
        return nil
    }
    
    var link: String {
        return item.link
    }
    
    var price: String {
        return (item.price.toPrice + "원")
    }
    
    var sale: String {
        if item.sale > 0 {
            return (String(format: "%.0f", item.sale) + "%")
        }
        return ""
    }
    
    var coupon: Bool {
        return item.coupon
    }
    
    var rank: String {
        return "\(item.order)위"
    }
    
    init(item: GoodsListItem) {
        self.item = item
        
    }
}
