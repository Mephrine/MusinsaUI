//
//  ADSlideBannerItemCell.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/12.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class ADSlideBannerItemCell: UICollectionViewCell {
    var ivBanner: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(ivBanner)
        self.ivBanner.makeConstSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    # configure
    - Author: Mephrine
    - Date: 20.06.12
    - Parameters:
     - url : 배너 이미지 URL
    - Returns:
    - Note: 셀에 데이터 적용
    */
    func configure(_ url: URL) {
        self.ivBanner.kf.setImage(with: url)
    }
}
