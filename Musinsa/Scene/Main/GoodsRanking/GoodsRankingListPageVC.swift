//
//  GoodsRankingListPageVC.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class GoodsRankingListPageVC: UICollectionViewController, ViewControllerProtocol {
    // reusable
    let reusableCell = "GoodsRankingListItemCell"
    
    // viewModel
    var viewModel: GoodsRankingListPageVM?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    //MARK: - Bind
    func bind() {
        guard let viewModel = self.viewModel else { return }
        viewModel.item.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }
    
    //MARK: - e.g.
    func initView() {
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionView.register(UINib(nibName: reusableCell, bundle: nil), forCellWithReuseIdentifier: reusableCell)
        self.collectionView.isScrollEnabled  = false
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            let width = self.collectionView.bounds.width / 3
            let height = width + 50
            flowLayout.itemSize = CGSize.init(width: width, height: height)
        }
    }
    
}

//MARK: - DataSource
extension GoodsRankingListPageVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cnt() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath) as? GoodsRankingListItemCell, let item = viewModel?.list() {
            let cellModel = GoodsRankingListItemModel(item: item[index])
            cell.configure(model: cellModel)
        }
       
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        guard let viewModel = viewModel, let strURL = viewModel.item(index)?.link else { return }
        
        viewModel.linkURL.value = strURL
    }
}
