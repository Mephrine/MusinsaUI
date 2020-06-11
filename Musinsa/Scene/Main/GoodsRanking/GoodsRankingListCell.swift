//
//  GoodsRankingListCell.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) GoodsRankingListCell.swift
 - Author: Mephrine
 - Date: 20.06.10
 - Note: 상품 랭킹 리스트 Cell
*/
class GoodsRankingListCell: BaseCollectionViewCell {
    @IBOutlet weak var cvTabBar: UICollectionView!
    @IBOutlet weak var vContainer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.cvTabBar.dataSource = self
        self.cvTabBar.delegate   = self
        self.cvTabBar.register(UINib(nibName: itemCell, bundle: nil), forCellWithReuseIdentifier: itemCell)
        self.cvTabBar.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if let flowLayout = cvTabBar.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize.init(width: 60, height: 100)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    func configure(model: GoodsRankingListModel) {
        
    }
}

extension GoodsRankingListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as? WeatherCenterItemCell {
            
//            let cellModel = WeatherCenterModel(itemList[index])
//            cell.configuration(item: cellModel, index: index)
//            return cell
//        }
        
        return UICollectionViewCell()
    }
}

