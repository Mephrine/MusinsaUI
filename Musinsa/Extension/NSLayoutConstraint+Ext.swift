//
//  NSLayoutConstraint+Ext.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    /**
    # addIdAndActive
    - Author: Mephrine
    - Date: 20.06.11
    - Parameters:
        - id: NSLayoutConstraint identifier
    - Returns: NSLayoutConstraint
    - Note: identifier 지정 및 활성화
    */
    @discardableResult
    func addIdAndActive(_ id: String) -> NSLayoutConstraint {
        self.identifier = id
        self.isActive = true
        return self
    }
    
    /**
    # setPriority
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - value : 우선순위
    - Returns:
    - Note: NSLayoutConstraint 우선순위 지정
    */
    @discardableResult
    func setPriority(_ value: Float?) -> NSLayoutConstraint {
        guard value != nil else { return self }
        self.priority = .init(rawValue: value!)
        return self
    }
    
    /**
    # reamkeMultiplier
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - multiplier : multiplier 값
    - Returns: NSLayoutConstraint
    - Note: NSLayoutConstraint multiplier 지정
    */
    func reamkeMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(item: self.firstItem,
                                              attribute: firstAttribute,
                                              relatedBy: self.relation,
                                              toItem: self.secondItem,
                                              attribute: self.secondAttribute,
                                              multiplier: multiplier,
                                              constant: self.constant)
        // View가 가지고 있는 기본 셋팅값을 사용하겠다는 코드
        newConstraint.priority = self.priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

