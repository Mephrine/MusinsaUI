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
    let navi: Navigator
    private var index = 0
    
    var list: [GoodsList] {
        return [item.all, item.top, item.outer, item.pants, item.bag, item.sneakers, item.shoes].sorted{ $0.order < $1.order }
    }
    
    var listTabNm: [String] {
        return self.list.map{ $0.name }
    }
    
    init(item: GoodsRanking, navigator: Navigator) {
        self.item = item
        self.navi = navigator
    }
    
    func tabList(tabNm: String) -> GoodsList {
        return self.list.filter{ $0.name == tabNm }.first!
    }
    
    func isSelected(_ index: Int) -> Bool {
        return self.index == index
    }
    
    func tabItemModel(index: Int) -> GoodsRankingTabItemModel {
        return GoodsRankingTabItemModel(tabNm: listTabNm[index], index: index, isSelected: isSelected(index))
    }
    
    func cnt() -> Int {
        return self.list.count
    }
    
    // struct라서 value이기 때문에, mutating 사용
    mutating func setIndex(_ index: Int) {
        self.index = index
    }
    
    func currentIndex() -> Int {
        return self.index
    }
    
    //loop
    func beforeLoadIndex() -> Int?  {
        if( self.index <= 0) {
            return self.cnt() - 1
        }
       
        guard self.cnt() > self.index - 1 else {
            return nil
        }
        
        return self.index - 1
    }
    
    //loop
    func afterLoadIndex() -> Int? {
        if( self.index >= self.cnt() - 1) {
            return  0
        }
        
        guard self.cnt() > self.index + 1 else {
            return nil
        }
        
        return self.index + 1
    }
    
}
