//
//  GoodsRankingHeaderCell.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) GoodsRankingHeaderCell.swift
 - Author: Mephrine
 - Date: 20.06.10
 - Note: 상품 랭킹 헤더뷰
*/
class GoodsRankingHeaderCell: BaseCollectionViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbUpdateTime: UILabel!
    
    var navigator: Navigator?
    var linkURL: String?
    
    @IBAction func tapBtnAll(_ sender: UIButton) {
        guard let navi = navigator, let link = linkURL else { return }
        navi.goDetail(url: link)
    }
    
    func configure(model: GoodsRankingHeaderModel) {
        self.lbTitle.text = model.title
        self.lbUpdateTime.text = model.time
        self.navigator = model.navi
    }
}
