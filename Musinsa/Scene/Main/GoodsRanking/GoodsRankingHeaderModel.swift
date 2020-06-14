//
//  GoodsRankingHeaderModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) GoodsRankingHeaderModel.swift
 - Author: Mephrine
 - Date: 20.06.11
 - Note: GoodsRankingHeader 뷰모델
*/
struct GoodsRankingHeaderModel {
    let item: GoodsHeader
    let navi: Navigator
    var title: String {
        return item.title
    }
    
    var time: String {
        let date = Date(timeIntervalSince1970: item.timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd HH:mm"
        
        return formatter.string(from: date) + " 갱신"
    }
    
    var linkURL: String {
        return item.link
    }
    
    init(item: GoodsHeader, navigator: Navigator) {
        self.item = item
        self.navi = navigator
    }
    
    //MARK: - Navigation
    /**
    # goDetail
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns:
    - Note: 상세화면으로 이동
    */
    func goDetail() {
        self.navi.goDetail(url: linkURL)
    }
}
