//
//  Dynamic.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

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
    
//    func bind(_ listener: Listener?) {
//        self.listener = listener
//    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
