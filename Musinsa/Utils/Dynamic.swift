//
//  Dynamic.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (C) Dynamic.swift
 - Author: Mephrine
 - Date: 20.06.09
 - Note: bind를 위해 사용되는 클래스
*/
class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    /**
     # bind
     - Author: Mephrine
     - Date: 20.06.09
     - Parameters:
        - listener : 실행될 클로저
     - Returns:
     - Note: bind 를 구현한 함수
    */
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
