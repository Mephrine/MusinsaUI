//
//  BaseVC.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol: class {
    associatedtype ViewModel = BaseVM
    var viewModel: ViewModel? { get set }
    
    func bind()
}

class BaseVC: UIViewController {
    //MARK: - var
//    var viewModel: BaseVM?
    var statusBarShouldBeHidden = false
    
    // PopGesture 플래그 변수
    private var isViewControllerPopGesture = true
    
    private var scrollViewOriginalContentInsetAdjustmentBehaviorRawValue: Int?
    
    //제스쳐 관련 플래그 변수
    private var isPopGesture = true
    private var isPopSwipe = false
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 자동으로 스크롤뷰 인셋 조정하는 코드 막기
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.initView()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setInteractivePopGesture(isViewControllerPopGesture)
        
        // fix iOS 11 scroll view bug
        if #available(iOS 11, *) {
            if let scrollView = self.view.subviews.first as? UIScrollView {
                self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue =
                    scrollView.contentInsetAdjustmentBehavior.rawValue
                scrollView.contentInsetAdjustmentBehavior = .never
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fix iOS 11 scroll view bug
        if #available(iOS 11, *) {
            if let scrollView = self.view.subviews.first as? UIScrollView,
                let rawValue = self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue,
                let behavior = UIScrollView.ContentInsetAdjustmentBehavior(rawValue: rawValue) {
                scrollView.contentInsetAdjustmentBehavior = behavior
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isPopSwipe {
            if isPopGesture {
                popGesture()
            }
            isPopSwipe = false
        }
    }
    
    //MARK: - UI
    func initView() {
        
    }
    
    //MARK: - Bind
    func bind(){
        
    }
    
    //MARK: - Navigation
    /**
     # popGesture
     - Author: Mephrine
     - Date: 20.02.10
     - Parameters:
     - Returns:
     - Note: ViewController에서 PopGesture시에 실행할 내용 정의하는 Override용 함수
    */
    func popGesture() {
        
    }
    
    //MARK: - StatusBar
    override var prefersStatusBarHidden: Bool {
        return statusBarShouldBeHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    //MARK: - e.g.
    /**
     # setInteractivePopGesture
     - Author: Mephrine
     - Date: 20.06.09
     - Parameters:
     - isRegi: PopGesture 적용 여부 Bool
     - Returns:
     - Note: ViewController PopGesture를 적용/해제하는 함수
     */
    func setInteractivePopGesture(_ isRegi:Bool = true) {
        if isRegi {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            isPopGesture = true
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            isPopGesture = false
        }
    }
    
    /**
     # safeAreaBottomAnchor
     - Author: Mephrine
     - Date: 20.06.09
     - Parameters:
     - Returns: CGFloat
     - Note: 현재 디바이스의 safeAreaBottom pixel값을 리턴하는 함수
    */
    var safeAreaBottomAnchor: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            return bottomPadding!
        } else {
            return bottomLayoutGuide.length
        }
    }
}

//MARK: -  UIGestureRecognizerDelegate. ViewController PopGesture 사용 / 해제를 위한 delegate 함수를 처리
extension BaseVC: UIGestureRecognizerDelegate {
    internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        switch gestureRecognizer.state {
        case .possible:
            isPopSwipe = true
            break
        case .began:
            isPopSwipe = true
            break
        case .changed:
            isPopSwipe = true
            break
        default:
            isPopSwipe = false
            break
        }
        return true
    }
}

//MARK: -  Storyboard & ViewModel로 ViewController 생성하는 용도.
extension ViewControllerProtocol where Self: BaseVC {
    static func instantiate<T> (withViewModel viewModel: T, storyBoardName: String = "Main") -> Self? where T == Self.ViewModel {
        let sb = UIStoryboard.init(name: storyBoardName, bundle: nil)
        if let viewController = sb.instantiateViewController(withIdentifier: String(describing: self)) as? Self {
            viewController.viewModel = viewModel
            return viewController
        }
        
        return nil
    }
    
    static func instantiatee<T> (withViewModel viewModel: T, storyBoardName: String = "Main") -> Self {
        let sb = UIStoryboard.init(name: storyBoardName, bundle: nil)
//        if let viewController = sb.instantiateViewController(withIdentifier: String(describing: self)) as? Self {
//            viewController.viewModel = viewModel
//            return viewController
//        }
        
        return UIViewController() as! Self
    }
}
