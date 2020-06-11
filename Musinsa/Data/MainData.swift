//
//  MainData.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

struct MainData: Codable {
    let slideBanner: [ADSlideBanner]?
    let bandBanner: ADBandBanner?
    let ranking: GoodsRanking?
    
    enum CodingKeys: String, CodingKey {
        case slideBanner = "slidebanner"
        case bandBanner = "bandbanner"
        case ranking = "rank"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.slideBanner = (try? values.decode([ADSlideBanner].self, forKey: .slideBanner))
        self.bandBanner = (try? values.decode(ADBandBanner.self, forKey: .bandBanner))
        self.ranking = (try? values.decode(GoodsRanking.self, forKey: .ranking))
    }
}
