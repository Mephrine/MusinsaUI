//
//  MainVM.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/09.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

fileprivate protocol MainProtocol {
    //Input
    var requestAPI: Dynamic<Bool> { get set }
    
    // Output
    var mainData: Dynamic<MainData?> { get set }
    var errorMsg: Dynamic<CallAPI.APIError> { get set }
    
    //func
    func requsetMain()
}

final class MainVM: BaseVM, MainProtocol {
    //MARK: - var & typealias
    // Input
    var requestAPI: Dynamic<Bool> = Dynamic(false)
    
    // Output
    var mainData: Dynamic<MainData?> = Dynamic(nil)
    var errorMsg: Dynamic<CallAPI.APIError> = Dynamic(.none)
    
    //service
    typealias Service = HasMainService
    private var service: Service
    let navigator: Navigator
    
    init(service: AppService, navigator: Navigator) {
        self.service = service
        self.navigator = navigator
        super.init()
        self.bind()
    }
    
    //MARK: - bind
    func bind() {
        self.requestAPI.bind { [weak self] result in
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
                self.mainData.value = data
                break
            case .failure(let error):
                self.errorMsg.value = error
                break
            }
        }
    }
}
