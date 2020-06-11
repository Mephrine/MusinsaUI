//
//  BaseVM.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input?) -> Output
}

class BaseVM {
    
}
