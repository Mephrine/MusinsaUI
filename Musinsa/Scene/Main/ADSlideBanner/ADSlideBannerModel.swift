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
    let navi: Navigator
    private var index = 0
    
    var maxPage: String {
        return String(item.count)
    }
    
    init(item: [ADSlideBanner], navigatior: Navigator) {
        self.item = item
        self.navi = navigatior
    }
    
    func currentIndex() -> Int {
        return self.index
    }
    
    mutating func setIndex(_ index: Int) {
        self.index = index
    }
    
    func cnt() -> Int {
        return self.item.count
    }
    
    //loop
    func beforeLoadIndex() -> Int?  {
        if( self.index <= 0) {
            return self.item.count - 1
        }
       
        guard self.cnt() > self.index - 1 else {
            return nil
        }
        
        return self.index - 1
    }
    
    //loop
    func afterLoadIndex() -> Int? {
        if( self.index >= self.item.count - 1) {
            return  0
        }
        
        guard self.cnt() > self.index + 1 else {
            return nil
        }
        
        return self.index + 1
    }
    
    func goDetail() {
        navi.goDetail(url: item[index].link)
    }
}
