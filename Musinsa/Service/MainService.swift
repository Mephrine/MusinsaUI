//
//  MainService.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

protocol HasMainService {
    var mainService: MainService { get }
}

class MainService {
    // MARK: - API List
    /**
     # mainData
     - Author: Mephrine
     - Date: 20.06.11
     - Parameters:
        - completeion : 결과값 Closure
     - Returns:
     - Note: 현재 메인 API 조회 및 결과값 반환
    */
    func mainData(_ completion: @escaping (Result<MainData, CallAPI.APIError>) -> Void) {
        LoadingView.shared.show()
        CallAPI.shared.mainData { result in
            completion(result)
        }
    }
}
