//
//  Navigator.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit
import SafariServices

class Navigator {
    let navigation: UINavigationController
    
    init(navi: UINavigationController) {
        self.navigation = navi
    }
    
    private func showNavigtaionBar() {
        navigation.setNavigationBarHidden(false, animated: true)
    }
    
    func hideNavigationBar() {
        navigation.setNavigationBarHidden(true, animated: true)
    }
    
    func goDetail(url: String) {
        self.showNavigtaionBar()
        
        let detailVM = DetailVM(linkURL: url, navigator: self)
        if let detailVC = DetailVC.instantiate(withViewModel: detailVM) {
            let button = UIButton(frame: CGRect.zero)
            button.addTarget(detailVM, action: #selector(detailVM.tapBtnBack), for: .touchUpInside)
            button.setImage(UIImage(named: "navi_back"), for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 27)
                    
            let naviItem = UIBarButtonItem.init(customView: button)
            naviItem.customView?.makeConstWH(width: 40, height: 40)
            
            detailVC.navigationItem.leftBarButtonItem = naviItem
            navigation.pushViewController(detailVC, animated: true)
        }
    }
    
    /**
    # showSFVC
    - Author: Mephrine
    - Date: 20.06.09
    - Parameters:
       - url : URL 타입 링크
    - Returns: FlowContributors
    - Note: SafariVC로 링크 실행.
    */
    func showSFVC(strURL: String) {
        if let url = URL(string: strURL) {
            let sfVC = SFSafariViewController(url: url)
            self.navigation.present(sfVC, animated: true)
        }
    }
    
    /**
    # openTelNumber
    - Author: Mephrine
    - Date: 20.06.09
    - Parameters:
       - urlStr : String 타입 전화번호
    - Returns:
    - Note: 전화걸기 알럿 노출 및 전화걸기 Action.
    */
    func openTelNumber(urlStr: String, _ cancelTitle: String = "취소", _ completeTitle: String = "통화" ) {
        guard let vc = navigation.visibleViewController else { return }
        if #available(iOS 11.0, *) {
            Utils.openExternalLink(urlStr: urlStr)
        } else {
            if #available(iOS 10.0, *) {
                if let phoneNumber = urlStr.split(separator: ":").last {
                    CommonAlert.showConfirm(vc: vc, message: String(phoneNumber), cancelTitle: cancelTitle, completeTitle: completeTitle, nil) {
                        Utils.openExternalLink(urlStr: urlStr)
                    }
                }
            } else {
                Utils.openExternalLink(urlStr: urlStr)
            }
        }
    }
    
    @objc func backToMain() {
        self.hideNavigationBar()
        self.navigation.popViewController(animated: true)
    }
}
