//
//  ADBandBannerCell.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit
import Kingfisher
/**
 # (C) ADBandBannerCell.swift
 - Author: Mephrine
 - Date: 20.06.10
 - Note: 광고 띠 배너 Cell
*/
class ADBandBannerCell: BaseCollectionViewCell {
    @IBOutlet weak var ivBanner: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    
    var model: ADBandBannerModel? = nil
    
    /**
    # configure
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
     - model : 해당 셀에서 사용할 Model
    - Returns:
    - Note: 셀에 데이터 적용
    */
    func configure(model: ADBandBannerModel) {
        self.model = model
        self.lbTitle.text = model.title
        self.lbSubTitle.text = model.subTitle
        self.ivBanner.superview?.backgroundColor = model.colorBG
        self.ivBanner.kf.setImage(with: model.imageURL)
    }
    
    /**
    # tapBtnBanner
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
    - Returns:
    - Note: 현재 페이지를 클릭했을 때 실행되는 함수
    */
    @IBAction func tapBtnBanner(_ sender: Any) {
        model?.goDetail()
    }
}

