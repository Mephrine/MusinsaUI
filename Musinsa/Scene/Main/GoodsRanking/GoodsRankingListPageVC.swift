//
//  GoodsRankingListPageVC.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class GoodsRankingListPageVC: BaseVC, ViewControllerProtocol {
    @IBOutlet var cvList: UICollectionView!
    // reusable
    let reusableCell = "GoodsRankingListItemCell"
    
    // viewModel
    var viewModel: GoodsRankingListPageVM?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Bind
    override func bind() {
        guard let viewModel = self.viewModel else { return }
        viewModel.item.bind { [weak self] _ in
            self?.cvList.reloadData()
        }
    }
    
    //MARK: - e.g.
    override func initView() {
        self.cvList.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.cvList.register(UINib(nibName: reusableCell, bundle: nil), forCellWithReuseIdentifier: reusableCell)
        self.cvList.isScrollEnabled  = false
        
        if let flowLayout = self.cvList.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            let width = self.cvList.bounds.width / 3
            let height = width + 50
            flowLayout.itemSize = CGSize.init(width: width, height: height)
        }
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
        }
       
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        guard let viewModel = viewModel, let strURL = viewModel.item(index)?.link else { return }
        
        viewModel.linkURL.value = strURL
    }
}
