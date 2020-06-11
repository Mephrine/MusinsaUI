//
//  MainVC.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) MainVC.swift
 - Author: Mephrine
 - Date: 20.06.10
 - Note: 메인 화면 페이지 ViewController
*/
final class MainVC: BaseVC, ViewControllerProtocol {
    //MARK: - let
    // Cell Resuable  Identifier
    private let adSlideBannerCell            = "ADSlideBannerCell"
    private let adBandBannerCell             = "ADBandBannerCell"
    private let goodsRankingHeaderCell       = "GoodsRankingHeaderCell"
    private let goodsRankingListCell         = "GoodsRankingListCell"
    
    //MARK: - var
    @IBOutlet weak var cvMain: UICollectionView!
    var viewModel: MainVM?
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.requestAPI = Dynamic(true)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - Bind
    override func bind() {
        guard let viewModel = viewModel else { return }
        
        viewModel.mainData?.bind({ [weak self] data in
            self?.cvMain.reloadData()
        })
        
        viewModel.errorMsg?.bind({ [weak self] error in
            LoadingView.shared.hide {
                DispatchQueue.main.async {
                    if error != .noData {
                        if let _self = self {
                            _self.cvMain.reloadData()
                            CommonAlert.showAlert(vc: _self, message: error.localizedDescription)
                        }
                    }
                }
            }
        })
    }
    
    //MARK: - UI
    override func initView() {
        //tableView configuration
        cvMain.delegate = self
        cvMain.dataSource = self
        cvMain.backgroundColor = .clear
        if #available(iOS 11.0, *) {
            cvMain.contentInsetAdjustmentBehavior = .never
        }
        cvMain.alwaysBounceVertical = false
        cvMain.bounces = false
        
        // flowLayout
        if let flowLayout = cvMain.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0.0
            flowLayout.minimumLineSpacing      = 20
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.estimatedItemSize = CGSize.init(width: Utils.SCREEN_WIDTH, height: cvMain.frame.size.height)
            flowLayout.itemSize = CGSize.init(width: Utils.SCREEN_WIDTH, height: cvMain.frame.size.height)
        }
        
        // register
        cvMain.register(UINib(nibName:adSlideBannerCell, bundle: nil), forCellWithReuseIdentifier: adSlideBannerCell)
        cvMain.register(UINib(nibName:adBandBannerCell, bundle: nil), forCellWithReuseIdentifier: adBandBannerCell)
        cvMain.register(UINib(nibName:goodsRankingHeaderCell, bundle: nil), forCellWithReuseIdentifier: goodsRankingHeaderCell)
        cvMain.register(UINib(nibName:goodsRankingListCell, bundle: nil), forCellWithReuseIdentifier: goodsRankingListCell)
        
        cvMain.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.safeAreaBottomAnchor, right: 0)
    }
    
    //MARK: - e.g.
    
}


extension MainVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return adSlideBannerCell(collectionView, cellForRowAt: indexPath)
        case 1:
            return adBandBannerCell(collectionView, cellForRowAt: indexPath)
        case 2:
            switch indexPath.row {
            case 0:
                return goodsRankingHeaderCell(collectionView, cellForRowAt: indexPath)
            case 1:
                return goodsRankingListCell(collectionView, cellForRowAt: indexPath)
            default:
                break
            }
        default:
            break
        }
        return UICollectionViewCell()
    }
}

extension MainVC  {
    func adSlideBannerCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> ADSlideBannerCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: adSlideBannerCell, for: indexPath) as! ADSlideBannerCell
        if let viewModel = self.viewModel, let data = viewModel.mainData?.value.slideBanner {
            let cellModel = ADSlideBannerModel(item: data)
            cell.configure(model: cellModel)
        }
        
        return cell
    }
    
    func adBandBannerCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> ADBandBannerCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: adBandBannerCell, for: indexPath) as! ADBandBannerCell
        if let viewModel = self.viewModel, let data = viewModel.mainData?.value.bandBanner {
            let cellModel = ADBandBannerModel(item: data)
            cell.configure(model: cellModel)
        }
        
        return cell
    }
    
    func goodsRankingHeaderCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> GoodsRankingHeaderCell {
        // 헤더
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goodsRankingHeaderCell, for: indexPath) as! GoodsRankingHeaderCell
        if let viewModel = self.viewModel, let data = viewModel.mainData?.value.ranking?.header {
            let cellModel = GoodsRankingHeaderModel(item: data)
            cell.configure(model: cellModel)
        }
        
        return cell
    }
    
    func goodsRankingListCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> GoodsRankingListCell {
        // 헤더
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goodsRankingListCell, for: indexPath) as! GoodsRankingListCell
        if let viewModel = self.viewModel, let data = viewModel.mainData?.value.ranking {
            let cellModel = GoodsRankingListModel(item: data)
            cell.configure(model: cellModel)
        }
        
        return cell
    }
}
