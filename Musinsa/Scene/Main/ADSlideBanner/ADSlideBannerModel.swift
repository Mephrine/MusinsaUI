//
//  ADSlideBannerModel.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) ADSlideBannerModel.swift
 - Author: Mephrine
 - Date: 20.06.11
 - Note: ADSlideBanner 뷰모델
*/
struct ADSlideBannerModel {
    let item: [ADSlideBanner]
    
    // 네비게이션
    let navi: Navigator
    
    // 셀 재사용 시, 해당 인덱스 유지를 위해 static으로 정의
    private static var index = 0
    
    var maxPage: String {
        return String(item.count)
    }
    
    init(item: [ADSlideBanner], navigatior: Navigator) {
        self.item = item
        self.navi = navigatior
    }
    
    //MARK: - e.g.
    /**
    # currentIndex
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns:
    - Note: 현재 인덱스 반환
    */
    func currentIndex() -> Int {
        return ADSlideBannerModel.index
    }
    
    /**
    # setIndex
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
        - index : 지정할 index
    - Returns:
    - Note: 현재 인덱스 변경
    */
    mutating func setIndex(_ index: Int) {
        ADSlideBannerModel.index = index
    }
    
    /**
    # cnt
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns: Int
    - Note: 아이템 리스트 카운트 반환
    */
    func cnt() -> Int {
        return self.item.count
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
        if( ADSlideBannerModel.index <= 0) {
            return self.item.count - 1
        }
       
        guard self.cnt() > ADSlideBannerModel.index - 1 else {
            return nil
        }
        
        return ADSlideBannerModel.index - 1
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
        if( ADSlideBannerModel.index >= self.item.count - 1) {
            return  0
        }
        
        guard self.cnt() > ADSlideBannerModel.index + 1 else {
            return nil
        }
        
        return ADSlideBannerModel.index + 1
    }
    
    //MARK: - Navigation
    /**
    # goDetail
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
    - Returns:
    - Note: 상세 페이지로 이동
    */
    func goDetail() {
        navi.goDetail(url: item[ADSlideBannerModel.index].link)
    }
}
