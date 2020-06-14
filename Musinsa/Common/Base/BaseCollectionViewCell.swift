//
//  BaseCollectionViewCell.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) BaseCollectionViewCell.swift
 - Author: Mephrine
 - Date: 20.06.09
 - Note: 모든 UICollectionView Cell에 공통적으로 적용하기 위한 부모 셀 - 셀 높이 유동적으로 적용하기
*/
class BaseCollectionViewCell: UICollectionViewCell {
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        setNeedsLayout()
        layoutIfNeeded()

        // 최신으로 반영된 상태의 contentView의 사이즈로 적용.
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }
}
