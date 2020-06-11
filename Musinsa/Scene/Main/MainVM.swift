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
    var linkURL: Dynamic<String?> { get set }
    
    // Output
    var mainData: Dynamic<MainData>? { get set }
    var errorMsg: Dynamic<CallAPI.APIError>? { get set }
    
    //func
    func requsetMain()
    func goDetail(url: String)
}

final class MainVM: BaseVM, MainProtocol {
    //MARK: - var & typealias
    // Input
    var requestAPI: Dynamic<Bool> = Dynamic(false)
    var linkURL: Dynamic<String?> = Dynamic(nil)
    
    // Output
    var mainData: Dynamic<MainData>?
    var errorMsg: Dynamic<CallAPI.APIError>?
    
    //service
    typealias Service = HasMainService
    private var service: Service
    private var navigator: Navigator
    
    init(service: AppService, navigator: Navigator) {
        self.service = service
        self.navigator = navigator
        self.errorMsg = Dynamic(.none)
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
        
        self.linkURL.bind({ [weak self] strUrl in
            if let url = strUrl {
                self?.goDetail(url: url)
            }
        })
    }
    
    //MARK: - e.g.
    fileprivate func requsetMain() {
        service.mainService.mainData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.mainData = Dynamic(data)
                break
            case .failure(let error):
                self.errorMsg = Dynamic(error)
                break
            }
        }
    }
    
    //MARK: - Navigation
    func goDetail(url: String) {

    }
}
