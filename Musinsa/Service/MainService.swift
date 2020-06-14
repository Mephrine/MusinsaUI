//
//  MainService.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/11.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (P) HasMainService
 - Author: Mephrine
 - Date: 20.06.09
 - Note: Main Service를 사용하는지에 대한 여부
*/
protocol HasMainService {
    var mainService: MainService { get }
}

/**
 # (C) MainService
 - Author: Mephrine
 - Date: 20.06.09
 - Note: 메인 API 관련 서비스
*/
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
