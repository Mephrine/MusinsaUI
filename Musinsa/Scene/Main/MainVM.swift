//
//  MainVM.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (S) MainProtocol
 - Author: Mephrine
 - Date: 20.06.09
 - Note: Main 뷰모델에서 정의해야할 프로토콜
*/
fileprivate protocol MainProtocol {
    //Input
    var requestAPI: Dynamic<Bool>? { get set }
    
    // Output
    var mainData: Dynamic<MainData?>? { get set }
    var errorMsg: Dynamic<CallAPI.APIError>? { get set }
    
    //func
    func requsetMain()
}

/**
 # (S) MainVM.swift
 - Author: Mephrine
 - Date: 20.06.09
 - Note: Main 뷰모델
*/
final class MainVM: BaseVM, MainProtocol {
    // Input
    var requestAPI: Dynamic<Bool>? = Dynamic(false)
    
    // Output
    var mainData: Dynamic<MainData?>? = Dynamic(nil)
    var errorMsg: Dynamic<CallAPI.APIError>? = Dynamic(.none)
    
    // service
    typealias Service = HasMainService
    private var service: Service
    
    // 네비게이션
    let navigator: Navigator
    
    init(service: AppService, navigator: Navigator) {
        self.service = service
        self.navigator = navigator
        super.init()
        self.bind()
    }
    
    //MARK: - bind
    func bind() {
        self.requestAPI?.bind { [weak self] result in
            if result {
                self?.requsetMain()
            }
        }
    }
    
    //MARK: - e.g.
    fileprivate func requsetMain() {
        service.mainService.mainData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.mainData?.value = data
                break
            case .failure(let error):
                self.errorMsg?.value = error
                break
            }
        }
    }
    
    func deinitDynamic() {
        self.requestAPI = nil
        self.mainData = nil
        self.errorMsg = nil
    }
}
