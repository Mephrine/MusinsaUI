//
//  ADSlideBanner.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) ADSlideBanner
 - Author: Mephrine
 - Date: 20.06.11
 - Note: 메인 API 중 광고 슬라이드 배너 데이터 구조체
*/
struct ADSlideBanner: Codable {
    let order: Int
    let image: String
    let link: String
}
