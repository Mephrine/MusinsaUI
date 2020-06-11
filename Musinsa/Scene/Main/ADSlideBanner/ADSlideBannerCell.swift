//
//  ADSlideBannerCell.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) ADSlideBannerCell.swift
 - Author: Mephrine
 - Date: 20.06.10
 - Note: 광고 이미지 슬라이드 배너 Cell
*/
class ADSlideBannerCell: BaseCollectionViewCell {
    @IBOutlet weak var cvSlider: UICollectionView!
    @IBOutlet weak var lbCurrentPage: UILabel!
    @IBOutlet weak var lbTotPage: UILabel!
    
    func configure(model: ADSlideBannerModel) {
        
    }
}
