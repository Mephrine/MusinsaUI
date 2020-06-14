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

    var model: GoodsRankingHeaderModel?
    
    var linkURL: String?
    
    @IBAction func tapBtnAll(_ sender: UIButton) {
        model?.goDetail()
    }
    
    /**
    # configure
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
     - model : 해당 셀에서 사용할 Model
    - Returns:
    - Note: 셀에 데이터 적용
    */
    func configure(model: GoodsRankingHeaderModel) {
        self.model = model
        self.lbTitle.text = model.title
        self.lbUpdateTime.text = model.time
    }
}
