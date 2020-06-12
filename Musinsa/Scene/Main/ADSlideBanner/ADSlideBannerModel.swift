//
//  ADSlideBannerModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct ADSlideBannerModel {
    let item: [ADSlideBanner]
    
    var titleNm: String {
        return ""
    }
    
    var maxPage: String {
        return String(item.count)
    }
    
    init(item: [ADSlideBanner]) {
        self.item = item
    }
}
