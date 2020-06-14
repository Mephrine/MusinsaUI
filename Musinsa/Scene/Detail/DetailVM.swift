//
//  DetailVM.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) DetailProtocol
 - Author: Mephrine
 - Date: 20.06.09
 - Note: Detail 뷰모델에서 정의해야할 프로토콜
*/
fileprivate protocol DetailProtocol {
    //Input
    var requestWebViewURL: Dynamic<Bool> { get set }
    
    // Output
    var loadURL: Dynamic<String?> { get set }
}

/**
 # (S) DetailVM.swift
 - Author: Mephrine
 - Date: 20.06.09
 - Note: Detail 뷰모델
*/
final class DetailVM: BaseVM {
    // navigator
    private let navigator: Navigator
    
    // Input
    var requestWebViewURL: Dynamic<Bool>
    
    // Output
    var loadURL: Dynamic<String?> = Dynamic(nil)
    
    // State
    private var currentURL: String? = nil
    
    init(linkURL: String, navigator: Navigator) {
        self.navigator = navigator
        self.currentURL = linkURL
        requestWebViewURL = Dynamic(false)
        super.init()
        self.bind()
    }
    
    //MARK: - bind
    private func bind() {
        self.requestWebViewURL.bind { isRequest in
            if isRequest {
                self.loadURL.value = self.currentURL
            }
        }
    }
    
    //MARK: - e.g.
    func setCurrentURL(_ strURL: String) {
        self.currentURL = strURL
    }
    
    func decidePolicyFor(url: URL) -> Bool {
        let strUrl    = url.absoluteString
        
        if url.scheme == "http" || url.scheme == "https" {
            if strUrl.contains("/download") || strUrl.contains("/file/") {
                if strUrl.contains(".jpg") || strUrl.contains(".png") || strUrl.contains(".jpeg") || strUrl.contains(".gif") {
                    return true
                } else if strUrl.contains(".hwp") {
                    Utils.openExternalLink(urlStr: url.absoluteString)
                    return false
                } else {
                    navigator.showSFVC(strURL: url.absoluteString)
                    return false
                }
            } else if let domain = URL(string: WEB_DOMAIN)?.host, domain != url.host {
                if strUrl.hasSuffix("#") {
                    return false
                }else if url.host == "itunes.apple.com" || url.host == "phobos.apple.com" || url.host == ("itms-appss") || url.host == "apps.apple.com" {
                    Utils.openExternalLink(urlStr: url.absoluteString)
                    return false
                }
            }
            self.currentURL = strUrl
            return true
        } else if strUrl == "about:blank" {
            return false
        } else if strUrl.starts(with: "file://") {
            return false
        } else if strUrl.starts(with: "tel:") {
            navigator.openTelNumber(urlStr: strUrl)
            return false
        } else if strUrl.starts(with: "sms:") || strUrl.starts(with: "mailto:") {
            Utils.openExternalLink(urlStr: strUrl)
            return false
        }
        
        else{
            // 외부 앱 호출
            Utils.openExternalLink(urlStr: url.absoluteString)
            return true
        }
    }
    
    //MARK: - Navigation
    @objc func tapBtnBack() {
        navigator.backToMain()
    }
    
    func popGesture() {
        navigator.hideNavigationBar()
    }
}
