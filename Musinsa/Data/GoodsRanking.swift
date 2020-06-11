//
//  GoodsRanking.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

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

struct GoodsHeader: Codable {
    let title: String
    let timestamp: Double
    let link: String
}

struct GoodsList: Codable {
    let name: String
    let list: [GoodsListItem]?
}

struct GoodsListItem: Codable {
    let order: Int
    let image: String
    let link: String
    let name: String
    let price: Double
    let sale: Double
    let coupon: Bool
}
