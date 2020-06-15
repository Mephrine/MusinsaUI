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
    
    var pageVC: UIPageViewController?
    var model: GoodsRankingListModel? = nil
    
    lazy var pageContentsVC: [GoodsRankingListPageVC] = {
        var arrContentsVC = [GoodsRankingListPageVC]()
        for index in 0 ..< (model?.cnt() ?? 0) {
            let contentsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoodsRankingListPageVC") as! GoodsRankingListPageVC
            
            if let item = model?.list[index], let navi = model?.navi {
                let viewModel = GoodsRankingListPageVM(item: item, navigator: navi)
                contentsVC.viewModel = viewModel
            }
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
        self.cvTabBar.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        if let flowLayout = cvTabBar.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        // PageViewController
        let pageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageVC") as! UIPageViewController

        pageViewController.delegate = self
        pageViewController.dataSource = self

        self.vContainer.addSubview(pageViewController.view)

        pageViewController.view.makeConstSuperView()

        self.pageVC = pageViewController
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let pageHeight = (pageListCellWidth + 40) * 2 + 20
        self.vContainer.constraints.filter{ $0.identifier == "constContainerH" }.first?.constant = pageHeight
        
        setNeedsLayout()
        layoutIfNeeded()
        
        // 최신으로 반영된 상태의 contentView의 사이즈로 적용.
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }
    
    /**
    # configure
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
     - model : 해당 셀에서 사용할 Model
    - Returns:
    - Note: 셀에 데이터 적용
    */
    func configure(model: GoodsRankingListModel) {
        self.model = model
        
        if let firstVC = self.pageContentsVC.first {
            pageVC?.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    /**
     # changeViewController
     - Author: Mephrine
     - Date: 20.06.10
     - Parameters:
        - index : 이동할 페이지
     - Returns: ADSlideBannerPageVC
     - Note: index 페이지의 뷰컨트롤러 반환
     */
    private func changeViewController(index: Int) -> GoodsRankingListPageVC {
        let viewControler = pageContentsVC[index]
        
        return viewControler
    }
  
    /**
       # movePage
       - Author: Mephrine
       - Date: 20.06.10
       - Parameters:
        - index : 이동할 페이지
       - Returns:
       - Note: index 페이지로 이동
       */
    private func movePage(_ index: Int) {
        guard let pageVC = self.pageVC else { return }
        
        let nextViewController = pageContentsVC[index]
        let direction: UIPageViewController.NavigationDirection = (self.model?.moveForward(index) ?? true) ? .forward : .reverse
        
        pageVC.setViewControllers([nextViewController], direction: direction, animated: true, completion: { [weak self] completion in
            if completion {
                self?.model?.setIndex(index)
                self?.selectTab(index)
            }
        })
    }
    
    /**
    # movePage
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
     - index : 선택한 탭 index
    - Returns:
    - Note: 탭 선택 시 실행되는 함수
    */
    private func selectTab(_ index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.cvTabBar.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        self.cvTabBar.reloadData()
    }
}

extension GoodsRankingListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = indexPath.row
        let font = Utils.Font(.Bold, size: 12)
        let text = model?.tabNm(index: index) ?? ""
        let width = self.estimatedFrame(text: text, font: font).width + 31
        return CGSize(width: width, height: 36.0)
    }

    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: self.cvTabBar.bounds.width, height: 36.0)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if !(model?.isSelected(index) ?? true) {
            self.movePage(index)
        }
    }
}

extension GoodsRankingListCell: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let beforeIndex = model?.beforeLoadIndex() else {
            return nil
        }
        
        return changeViewController(index: beforeIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let afterIndex = model?.afterLoadIndex() else {
            return nil
        }
        
        return changeViewController(index: afterIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed && finished {
            if let currentVC = pageViewController.viewControllers?.first {
                let index = currentVC.view.tag
                model?.setIndex(index)
                self.selectTab(index)
            }
        }
    }
}
