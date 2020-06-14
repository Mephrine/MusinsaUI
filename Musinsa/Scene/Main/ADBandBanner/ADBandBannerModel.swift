//
//  ADBandBannerModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (S) ADBandBannerModel.swift
 - Author: Mephrine
 - Date: 20.06.11
 - Note: ADBandBannerPage 뷰모델
*/
struct ADBandBannerModel {
    private let item: ADBandBanner
    // 네비게이션
    private let navi: Navigator
    
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
    
    init(item: ADBandBanner, navigator: Navigator) {
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

