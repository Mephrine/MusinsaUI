//
//  GoodsRankingListPageVM.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (P) GoodsRankingListPageProtocol
 - Author: Mephrine
 - Date: 20.06.11
 - Note: GoodsRankingListPage 뷰모델에서 정의해야할 프로토콜
*/
fileprivate protocol GoodsRankingListPageProtocol {
    var linkURL: Dynamic<String?> { get set }
}

/**
 # (S) GoodsRankingListPageVM.swift
 - Author: Mephrine
 - Date: 20.06.11
 - Note: GoodsRankingListPage 뷰모델
*/
class GoodsRankingListPageVM: BaseVM, GoodsRankingListPageProtocol {
    // Input
    var linkURL: Dynamic<String?> = Dynamic(nil)
    
    // Output
    var item: Dynamic<GoodsList?> = Dynamic(nil)
    
    // 네비게이션
    var navigator: Navigator
    
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
    
    //MARK: - e.g.
    /**
    # item
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
       - index : 반환할 아이템의 index
    - Returns: GoodsListItem?
    - Note: 해당 index의 아이템 반환
    */
    func item(_ index: Int) -> GoodsListItem? {
        return item.value?.list?[index]
    }
    
    /**
    # cnt
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns: Int?
    - Note: 아이템 리스트 카운트
    */
    func cnt() -> Int? {
        return item.value?.list?.count
    }
    
    /**
    # list
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns: [GoodsListItem]?
    - Note: 리스트 전체 반환
    */
    func list() -> [GoodsListItem]? {
        return item.value?.list
    }
    
    //MARK: - Navigation
    /**
     # goDeatil
     - Author: Mephrine
     - Date: 20.06.11
     - Parameters:
        - strURL
     - Returns:
     - Note: 상세 화면 이동
     */
    private func goDeatil(_ strURL: String) {
        self.navigator.goDetail(url: strURL)
    }
}
