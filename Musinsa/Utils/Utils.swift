//
//  Utils.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2019 MUtils. All rights reserved.
//

import UIKit

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
        # (E) FONT_TYPE
         - Author: Mephrine
         - Date: 20.06.09
         - Note: 사용하는 폰트를 모아둔 enum
    */
    enum FONT_TYPE: String {
        case Medium = "AppleSDGothicNeo-Medium"
        case Regular = "AppleSDGothicNeo-Regular"
        case Bold = "AppleSDGothicNeo-Bold"
        case SemiBold = "AppleSDGothicNeo-SemiBold"
    }
    
    /**
    # Font
        - Author: Mephrine
        - Date: 20.06.09
        - Parameters:
            - type: 적용할 폰트 타입
            - size: 폰트 사이즈
        - Returns:
        - Note: 적용할 폰트 타입을 받아서 UIFont로 전환해주는 함수.
    */
    static func Font(_ type: FONT_TYPE, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
    
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
}
