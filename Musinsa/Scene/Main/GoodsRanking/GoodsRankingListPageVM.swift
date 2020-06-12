//
//  GoodsRankingListPageVM.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

fileprivate protocol GoodsRankingListPageProtocol {
    var linkURL: Dynamic<String?> { get set }
}

class GoodsRankingListPageVM: BaseVM, GoodsRankingListPageProtocol {
    //input
    var linkURL: Dynamic<String?> = Dynamic(nil)
    
    //service
    var navigator: Navigator
    var item: Dynamic<GoodsList?> = Dynamic(nil)
    
    init(item: GoodsList?, navigator: Navigator) {
        self.navigator = navigator
        super.init()
        
        self.item.value = item
        
        linkURL.bind { [weak self] in
            if let strURL = $0 {
                self?.goDeatil(strURL)
            }
        }
    }
    
    //MARK: - Navigation
    private func goDeatil(_ strURL: String) {
        self.navigator.goDetail(url: strURL)
    }
    
    func item(_ index: Int) -> GoodsListItem? {
        return item.value?.list?[index]
    }
    
    func cnt() -> Int? {
        return item.value?.list?.count
    }
    
    func list() -> [GoodsListItem]? {
        return item.value?.list
    }
}
