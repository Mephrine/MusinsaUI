//
//  UIViewController+Ext.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 KBIZ. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     # instantiate
     - Author: Mephrine
     - Date: 20.06.09
     - Parameters:
        - storyBoardName: Storyboard 명
     - Returns: Self
     - Note: 해당 Storyboard에서 현재 뷰컨트롤러를 생성
    */
    public func instantiate(storyBoardName: String) -> Self {
        let sb = UIStoryboard.init(name: storyBoardName, bundle: nil)
        if let viewController = sb.instantiateViewController(withIdentifier: String(describing: self)) as? Self {
            return viewController
        }
        return self
    }
}


