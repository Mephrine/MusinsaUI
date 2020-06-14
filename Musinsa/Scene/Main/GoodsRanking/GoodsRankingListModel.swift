//
//  GoodsRankingListModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) GoodsRankingListModel.swift
 - Author: Mephrine
 - Date: 20.06.11
 - Note: GoodsRankingList 뷰모델
*/
struct GoodsRankingListModel {
    let item: GoodsRanking
    
    // 네비게이션
    let navi: Navigator
    
    // 셀 재사용 시, 해당 인덱스 유지를 위해 static으로 정의
    private static var index = 0
    
    // 리스트를 order 순으로 정렬
    var list: [GoodsList] {
        return [item.all, item.top, item.outer, item.pants, item.bag, item.sneakers, item.shoes].sorted{ $0.order < $1.order }
    }
    
    // 탭 이름
    var listTabNm: [String] {
        return self.list.map{ $0.name }
    }
    
    init(item: GoodsRanking, navigator: Navigator) {
        self.item = item
        self.navi = navigator
    }
    
    //MARK: - e.g.
    /**
    # tabList
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
     - tabNm : 탭 이름
    - Returns: GoodsList
    - Note: 탭 이름으로 해당 리스트 반환
    */
    func tabList(tabNm: String) -> GoodsList {
        return self.list.filter{ $0.name == tabNm }.first!
    }
    
    /**
     # isSelected
     - Author: Mephrine
     - Date: 20.06.11
     - Parameters:
        - index : 확인할 index
     - Returns: GoodsList
     - Note: 현재  index와 파라미터 index의 동일 여부
     */
    func isSelected(_ index: Int) -> Bool {
        return GoodsRankingListModel.index == index
    }
    
    /**
    # tabItemModel
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
       - index : 탭 index
    - Returns: GoodsRankingTabItemModel
    - Note: 해당 index의 탭 모델을 반환
    */
    func tabItemModel(index: Int) -> GoodsRankingTabItemModel {
        return GoodsRankingTabItemModel(tabNm: listTabNm[index], index: index, isSelected: isSelected(index))
    }
    
    /**
    # tabNm
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
       - index : 탭 index
    - Returns: String
    - Note: 해당 index의 탭 이름 반환
    */
    func tabNm(index: Int) -> String {
        return listTabNm[index]
    }
    
    /**
    # cnt
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns: Int
    - Note: 리스트의 카운트
    */
    func cnt() -> Int {
        return self.list.count
    }
    
    
    /**
    # setIndex
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
       - index : 변경할 index
    - Returns: String
    - Note: 현재 index를 해당 값으로 변경
    */
    /// struct라서 value이기 때문에, mutating 사용
    mutating func setIndex(_ index: Int) {
        GoodsRankingListModel.index = index
    }
    
    /**
    # moveForward
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
       - index : 확인할 index
    - Returns: Bool
    - Note: 이동할 방향이 forward인지 여부
    */
    func moveForward(_ index: Int) -> Bool {
        if GoodsRankingListModel.index < index {
            return true
        } else {
            return false
        }
    }
    
    /**
    # currentIndex
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns: Int
    - Note: 현재 인덱스 반환
    */
    func currentIndex() -> Int {
        return GoodsRankingListModel.index
    }
    
    /**
    # beforeLoadIndex
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns: Int?
    - Note: 이전 페이지 인덱스 반환 - 루프
    */
    func beforeLoadIndex() -> Int?  {
        if( GoodsRankingListModel.index <= 0) {
            return self.cnt() - 1
        }
       
        guard self.cnt() > GoodsRankingListModel.index - 1 else {
            return nil
        }
        
        return GoodsRankingListModel.index - 1
    }
    
    /**
    # afterLoadIndex
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns: Int?
    - Note: 다음 페이지 인덱스 반환 - 루프
    */
    func afterLoadIndex() -> Int? {
        if( GoodsRankingListModel.index >= self.cnt() - 1) {
            return  0
        }
        
        guard self.cnt() > GoodsRankingListModel.index + 1 else {
            return nil
        }
        
        return GoodsRankingListModel.index + 1
    }
    
}
