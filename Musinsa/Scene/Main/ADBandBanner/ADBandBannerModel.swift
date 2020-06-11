//
//  ADBandBannerModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

struct ADBandBannerModel {
    private let item: ADBandBanner
    
    var imageURL: URL? {
        if let url = URL(string: item.image) {
            return url
        }
        return nil
    }
    
    var colorBG: UIColor {
        return UIColor.init(red: item.red, green: item.green, blue: item.blue)
    }
    
    var title: String {
        return item.title
    }
    
    var subTitle: String {
        return item.subtitle
    }
    
    var linkURL: String {
        return item.link
    }
    
    init(item: ADBandBanner) {
        self.item = item
    }
}

