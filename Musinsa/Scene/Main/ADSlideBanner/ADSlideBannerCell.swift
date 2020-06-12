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
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var cvSlider: UICollectionView!
    @IBOutlet weak var lbCurrentPage: UILabel!
    @IBOutlet weak var lbTotPage: UILabel!
    
    var listBanner: [ADSlideBanner]?
    
    // let
    let reusableCell = "ADSlideBannerItemCell"
    
    
    
    func configure(model: ADSlideBannerModel) {
        self.listBanner = model.item
        
        self.cvSlider.dataSource = self
        self.cvSlider.delegate   = self
        self.cvSlider.register(ADSlideBannerItemCell.self, forCellWithReuseIdentifier: reusableCell)
        self.cvSlider.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.cvSlider.isPagingEnabled = true
        
        if let flowLayout = cvSlider.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize.init(width: Utils.SCREEN_WIDTH, height: 213)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    //MARK : - Action
    @IBAction func tapBtnNext(_ sender: Any) {
        self.moveNextPage()
    }
    
    //MARK: - e.g.
    fileprivate func moveNextPage() {
        
    }
}


extension ADSlideBannerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listBanner?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath) as? ADSlideBannerItemCell,
            let link = self.listBanner?[index].image,
            let url = URL(string: link) {
            cell.configure(url)
        }
        
        return UICollectionViewCell()
    }
    
    
}
