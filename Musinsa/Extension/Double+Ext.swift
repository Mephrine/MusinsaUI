//
//  Double+Ext.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/12.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

extension Double {
    var toPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: self as NSNumber)!
    }
}
