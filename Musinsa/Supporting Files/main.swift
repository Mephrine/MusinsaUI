//
//  ain.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/18.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

autoreleasepool {
    #if DEBUG
    #else
        disable_gdb()
    #endif
    
    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv)
            .bindMemory(
                to: UnsafeMutablePointer<Int8>.self,
                capacity: Int(CommandLine.argc)),
        nil,
        NSStringFromClass(AppDelegate.self)
    )
   
}
