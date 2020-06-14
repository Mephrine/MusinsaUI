//
//  GoodsRanking.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) GoodsRanking
 - Author: Mephrine
 - Date: 20.06.11
 - Note: 메인 API 중 상품 랭킹 데이터 구조체
*/
struct GoodsRanking: Codable {
    let header: GoodsHeader
    let all: GoodsList
    let top: GoodsList
    let outer: GoodsList
    let pants: GoodsList
    let bag: GoodsList
    let sneakers: GoodsList
    let shoes: GoodsList
}

/**
 # (S) GoodsHeader
 - Author: Mephrine
 - Date: 20.06.11
 - Note: 메인 API 중 상품 랭킹 상단 데이터 구조체
*/
struct GoodsHeader: Codable {
    let title: String
    let timestamp: Double
    let link: String
}

/**
 # (S) GoodsList
 - Author: Mephrine
 - Date: 20.06.11
 - Note: 메인 API 중 상품 랭킹 리스트 데이터 구조체
*/
struct GoodsList: Codable {
    let name: String
    let order: Int
    let list: [GoodsListItem]?
}

/**
 # (S) GoodsListItem
 - Author: Mephrine
 - Date: 20.06.11
 - Note: 메인 API 중 상품 랭킹 리스트 아이템 데이터 구조체
*/
struct GoodsListItem: Codable {
    let order: Int
    let image: String
    let link: String
    let name: String
    let price: Double
    let sale: Double
    let coupon: Bool
}
