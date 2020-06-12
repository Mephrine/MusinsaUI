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
    
    //let
    let reusableCell = "GoodsRankingTabItemCell"
    var model: GoodsRankingListModel? = nil
    lazy var pageContentsVC: [GoodsRankingListPageVC] = {
        var arrContentsVC = [GoodsRankingListPageVC]()
        for index in 0 ..< (model?.cnt() ?? 0) {
            let contentsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoodsRankingListPageVC") as! GoodsRankingListPageVC
            contentsVC.view.tag = index
            arrContentsVC.append(contentsVC)
        }
        return arrContentsVC
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //CollectionView
        self.cvTabBar.dataSource = self
        self.cvTabBar.delegate   = self
        self.cvTabBar.register(UINib(nibName: reusableCell, bundle: nil), forCellWithReuseIdentifier: reusableCell)
        self.cvTabBar.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if let flowLayout = cvTabBar.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.estimatedItemSize = CGSize.init(width: Utils.SCREEN_WIDTH, height: 100)
            flowLayout.itemSize = CGSize.init(width: Utils.SCREEN_WIDTH, height: 100)
        }
        
        // PageViewController
        let pageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageVC") as! UIPageViewController
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.setViewControllers(self.pageContentsVC, direction: .forward, animated: true, completion: nil)
        if let mainVC = self.window?.rootViewController?.presentingViewController as? MainVC {
            mainVC.addChild(pageViewController)
        }
        self.vContainer.addSubview(pageViewController.view)
        
        pageViewController.view.makeConstSuperView()
    }
    
    func configure(model: GoodsRankingListModel) {
        self.model = model
    }
}

extension GoodsRankingListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.cnt() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath) as? GoodsRankingTabItemCell, let model = self.model {
            let cellModel = model.tabItemModel(index: index)
            cell.configure(model: cellModel)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension GoodsRankingListCell: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let beforeIndex = model?.beforeLoadIndex() else {
            return nil
        }
        
        return pageContentsVC[beforeIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let afterIndex = model?.afterLoadIndex() else {
            return nil
        }
        
        return pageContentsVC[afterIndex]
    }
    
    
    
}
