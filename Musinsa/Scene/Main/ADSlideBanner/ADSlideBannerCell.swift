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
    @IBOutlet weak var lbCurrentPage: UILabel!
    @IBOutlet weak var lbTotPage: UILabel!
    
    var model: ADSlideBannerModel? = nil
    var pageVC: UIPageViewController?
    
    // 페이지뷰컨트롤러에서 보여질 뷰컨트롤러 리스트
    lazy var pageContentsVC: [ADSlideBannerPageVC] = {
        var arrContentsVC = [ADSlideBannerPageVC]()
        for index in 0 ..< (model?.cnt() ?? 0) {
            if let navi = model?.navi, let link = model?.item[index].link {
                let contentsVM = ADSlideBannerPageVM(link: link, navigator: navi)
                if let contentsVC = ADSlideBannerPageVC.instantiate(withViewModel: contentsVM) {
                    contentsVC.view.tag = index
                    arrContentsVC.append(contentsVC)
                }
            }
        }
        return arrContentsVC
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // PageViewController 생성 및 add
        let pageViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageVC") as! UIPageViewController
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        self.vContainer.addSubview(pageViewController.view)
        
        pageViewController.view.makeConstSuperView()
        
        self.pageVC = pageViewController
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
    func configure(model: ADSlideBannerModel) {
        self.model = model
        if let firstVC = self.pageContentsVC.first {
            pageVC?.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            
            if let strURL = model.item.first?.image {
                firstVC.configure(strURL)
            }
        }
        self.lbCurrentPage.text = String(model.currentIndex() + 1)
        self.lbTotPage.text = String(model.cnt())
    }
    
    //MARK : - Action
    /**
    # tapBtnNext
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
     - sender : 버튼 sender
    - Returns:
    - Note: 다음 페이지로 이동
    */
    @IBAction func tapBtnNext(_ sender: Any) {
        self.moveNextPage()
    }
    
    //MARK: - e.g.
    /**
    # moveNextPage
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
    - Returns:
    - Note: 다음 페이지로 이동
    */
    fileprivate func moveNextPage() {
        guard let pageVC = self.pageVC,
            let currentViewController = pageVC.viewControllers?.first,
            let nextViewController = pageVC.dataSource?.pageViewController(pageVC, viewControllerAfter: currentViewController),
            let afterIndex = model?.afterLoadIndex()
            else { return }
        
        pageVC.setViewControllers([nextViewController], direction: .forward, animated: true, completion: { [weak self] in
            if $0 {
                self?.model?.setIndex(afterIndex)
                self?.lbCurrentPage.text = String(afterIndex + 1)
            }
        })
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
    fileprivate func changeViewController(index: Int) -> ADSlideBannerPageVC {
        let viewControler = pageContentsVC[index]
        if let strURL = model?.item[index].image {
            viewControler.configure(strURL)
        }
        return viewControler
    }
    
    
}


extension ADSlideBannerCell: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
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
                self.lbCurrentPage.text = String(index + 1)
            }
        }
    }
}
