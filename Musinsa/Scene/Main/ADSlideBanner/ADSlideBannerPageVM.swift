//
//  ADSlideBannerPageVM.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/13.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (P) ADSlideBannerPageProtocol
 - Author: Mephrine
 - Date: 20.06.13
 - Note: ADSlideBannerPage 뷰모델에서의 정의해야할 프로토콜
*/
private protocol ADSlideBannerPageProtocol  {
    func goDetail()
}

/**
 # (S) ADSlideBannerPageVM.swift
 - Author: Mephrine
 - Date: 20.06.13
 - Note: ADSlideBannerPage 뷰모델
*/
final class ADSlideBannerPageVM: BaseVM, ADSlideBannerPageProtocol {
    // 네비게이션
    let navigator: Navigator
    
    // 상세 URL
    let linkURL: String
    
    init(link: String, navigator: Navigator) {
        self.navigator = navigator
        self.linkURL = link
        super.init()
    }
    
    //MARK: - Navigation
    /**
    # goDetail
    - Author: Mephrine
    - Date: 20.06.13
    - Parameters:
    - Returns:
    - Note: 상세화면으로 이동
    */
    func goDetail() {
        navigator.goDetail(url: self.linkURL)
    }
}
