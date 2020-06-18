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
    
    deinit {
        p("deinit MainVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.requestAPI?.value = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.deinitDynamic()
        viewModel = nil
    }
    
    //MARK: - Bind
    override func bind() {
        guard let viewModel = viewModel else { return }
        
        viewModel.mainData?.bind({ [weak self] data in
            guard data != nil else { return }
            LoadingView.shared.hide {
                DispatchQueue.main.async {
                    self?.cvMain.reloadData()
                }
            }
        })
        
        viewModel.errorMsg?.bind({ [weak self] error in
            guard error != .none else { return }
            LoadingView.shared.hide {
                DispatchQueue.main.async {
                    if error != .noData {
                        if let _self = self {
                            _self.cvMain.reloadData()
                            CommonAlert.showAlert(vc: _self, message: error.desc ?? error.localizedDescription)
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
        cvMain.backgroundColor = .white
        if #available(iOS 11.0, *) {
            cvMain.contentInsetAdjustmentBehavior = .never
        }
//        cvMain.alwaysBounceVertical = false
//        cvMain.bounces = false
        
        // flowLayout
        if let flowLayout = cvMain.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0.0
            flowLayout.minimumLineSpacing      = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
            flowLayout.estimatedItemSize = CGSize.init(width: Utils.SCREEN_WIDTH, height: cvMain.frame.size.height)
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


extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
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
        if let viewModel = self.viewModel, let data = viewModel.mainData?.value?.slideBanner {
            let cellModel = ADSlideBannerModel(item: data, navigatior: viewModel.navigator)
            cell.configure(model: cellModel)
        }
        
        return cell
    }
    
    func adBandBannerCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> ADBandBannerCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: adBandBannerCell, for: indexPath) as! ADBandBannerCell
        if let viewModel = self.viewModel, let data = viewModel.mainData?.value?.bandBanner {
            let cellModel = ADBandBannerModel(item: data, navigator: viewModel.navigator)
            cell.configure(model: cellModel)
        }
        
        return cell
    }
    
    func goodsRankingHeaderCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> GoodsRankingHeaderCell {
        // 헤더
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goodsRankingHeaderCell, for: indexPath) as! GoodsRankingHeaderCell
        if let viewModel = self.viewModel, let data = viewModel.mainData?.value?.ranking?.header {
            let cellModel = GoodsRankingHeaderModel(item: data, navigator: viewModel.navigator)
            cell.configure(model: cellModel)
        }
        
        return cell
    }
    
    func goodsRankingListCell(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> GoodsRankingListCell {
        // 헤더
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: goodsRankingListCell, for: indexPath) as! GoodsRankingListCell
        if let viewModel = self.viewModel, let data = viewModel.mainData?.value?.ranking {
            let cellModel = GoodsRankingListModel(item: data, navigator: viewModel.navigator)
            cell.configure(model: cellModel)
        }
        
        return cell
    }
}
