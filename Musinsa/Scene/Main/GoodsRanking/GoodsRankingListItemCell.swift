//
//  GoodsRankingListItemCell.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/12.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class GoodsRankingListItemCell: UICollectionViewCell {
    @IBOutlet weak var ivGoods: UIImageView!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbDiscount: UILabel!
    @IBOutlet weak var vCoupon: UIView!
    
    /**
    # configure
    - Author: Mephrine
    - Date: 20.06.12
    - Parameters:
     - model : 해당 셀에서 사용할 Model
    - Returns:
    - Note: 셀에 데이터 적용
    */
    func configure(model: GoodsRankingListItemModel) {
        self.lbRank.text = model.rank
        self.lbName.text = model.name
        self.lbPrice.text = model.price
        self.lbDiscount.text = model.sale
        self.vCoupon.isHidden = !model.coupon
        if let url = model.imageURL {
            self.ivGoods.kf.setImage(with: url)
        }
    }
}
