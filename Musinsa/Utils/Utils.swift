//
//  Utils.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2019 MUtils. All rights reserved.
//

import UIKit
import SafariServices

/**
 # (C) Utils
 - Author: Mephrine
 - Date: 20.06.09
 - Note: 공통적으로 사용하는 UI 관련 변수 및 함수 모음.
*/

// Logger
public func p(_ items: Any...) {
    #if DEBUG
    let output = items.map { "***\($0)***" }.joined(separator: " | ")
    Swift.print(output, terminator: "\n")
    #endif
}

public class Utils {
    public static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    public static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    public static let STATUS_HEIGHT = UIApplication.shared.statusBarFrame.size.height
    
    /**
     # openExternalLink
     - Author: Mephrine
     - Date: 20.06.09
     - Parameters:
        - urlStr : String 타입 링크
        - handler : Completion Handler
     - Returns:
     - Note: 외부 브라우저/ 외부 링크 실행.
     */
    public static func openExternalLink(urlStr: String, _ handler:(() -> Void)? = nil) {
        guard let url = URL(string: urlStr) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:]) { (result) in
                handler?()
            }
            
        } else {
            UIApplication.shared.openURL(url)
            handler?()
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
    public static func showSFVC(strURL: String, viewController: UIViewController) {
        if let url = URL(string: strURL) {
            let sfVC = SFSafariViewController(url: url)
            viewController.present(sfVC, animated: true, completion: nil)
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
    public static func openTelNumber(vc: UIViewController, urlStr: String, _ cancelTitle: String = "취소", _ completeTitle: String = "통화" ) {
        if #available(iOS 11.0, *) {
            self.openExternalLink(urlStr: urlStr)
        } else {
            if #available(iOS 10.0, *) {
                if let phoneNumber = urlStr.split(separator: ":").last {
                    CommonAlert.showConfirm(vc: vc, message: String(phoneNumber), cancelTitle: cancelTitle, completeTitle: completeTitle, nil) {
                        self.openExternalLink(urlStr: urlStr)
                    }
                }
            } else {
                self.openExternalLink(urlStr: urlStr)
            }
        }
    }
    
}
