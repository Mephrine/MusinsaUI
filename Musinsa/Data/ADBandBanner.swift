//
//  ADBandBanner.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) ADBandBanner
 - Author: Mephrine
 - Date: 20.06.11
 - Note: 메인 API 중 광고 띠 배너 데이터 구조체
*/
struct ADBandBanner: Codable {
    let image: String
    let red: Float
    let green: Float
    let blue: Float
    let title: String
    let subtitle: String
    let link: String
}
