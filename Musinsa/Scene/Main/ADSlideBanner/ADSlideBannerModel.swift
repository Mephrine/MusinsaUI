//
//  ADSlideBannerModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct ADSlideBannerModel {
    private let item: [ADSlideBanner]
    
    var titleNm: String {
        return ""
    }
    
    init(item: [ADSlideBanner]) {
        self.item = item
    }
}
