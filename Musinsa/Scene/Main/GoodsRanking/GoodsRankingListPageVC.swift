//
//  GoodsRankingListPageVC.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) GoodsRankingListPageVC.swift
 - Author: Mephrine
 - Date: 20.06.11
 - Note: 상품 랭킹 리스트 페이지 ViewController
*/
class GoodsRankingListPageVC: BaseVC, ViewControllerProtocol {
    @IBOutlet var cvList: UICollectionView!
    // reusable
    let reusableCell = "GoodsRankingListItemCell"
    
    // viewModel
    var viewModel: GoodsRankingListPageVM?
    
    //MARK: - Bind
    override func bind() {
        guard let viewModel = self.viewModel else { return }
        viewModel.item.bind { [weak self] _ in
            self?.cvList.reloadData()
        }
    }
    
    //MARK: - e.g.
    override func initView() {
        self.cvList.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.cvList.register(UINib(nibName: reusableCell, bundle: nil), forCellWithReuseIdentifier: reusableCell)
        self.cvList.isScrollEnabled  = false
        
        if let flowLayout = self.cvList.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing      = 10
            flowLayout.scrollDirection = .vertical
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

            let width = pageListCellWidth
            let height = width + 50
            flowLayout.itemSize = CGSize.init(width: width, height: height)
            flowLayout.estimatedItemSize = .zero
        }
        
        self.cvList.delegate = self
        self.cvList.dataSource = self
    }
    
}

//MARK: - DataSource
extension GoodsRankingListPageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cnt() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath) as? GoodsRankingListItemCell, let item = viewModel?.list() {
            let cellModel = GoodsRankingListItemModel(item: item[index])
            cell.configure(model: cellModel)
            
            return cell
        }
       
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        guard let viewModel = viewModel, let strURL = viewModel.item(index)?.link else { return }
        
        viewModel.linkURL.value = strURL
    }
}
