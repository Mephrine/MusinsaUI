//
//  ADSlideBannerPageVM.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/13.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

private protocol ADSlideBannerPageProtocol  {
    func goDetail()
}

final class ADSlideBannerPageVM: BaseVM, ADSlideBannerPageProtocol {
    let navigator: Navigator
    let linkURL: String
    
    init(link: String, navigator: Navigator) {
        self.navigator = navigator
        self.linkURL = link
        super.init()
    }
    
    func goDetail() {
        navigator.goDetail(url: self.linkURL)
    }
}
