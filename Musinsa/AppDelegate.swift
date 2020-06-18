//
//  AppDelegate.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    // API, UserDefaults 및 ThirdParty 관련 처리
    lazy var service: AppService = {
        return AppService(mainService: MainService())
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Light모드로만 진행
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
        
        let navigation = BaseNavigationController()
        navigation.setNavigationBarHidden(true, animated: false)

        let mainVM = MainVM(service: service, navigator: Navigator(navi: navigation))
        let mainVC = MainVC.instantiate(withViewModel: mainVM)!
        
        navigation.setViewControllers([mainVC], animated: false)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = navigation
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
}
