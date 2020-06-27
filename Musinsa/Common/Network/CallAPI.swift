//
//  CallAPI.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import Foundation

/**
 # (C) CallAPI.swift
 - Author: Mephrine
 - Date: 20.06.10
 - Note: 네트워크 통신 관련된 내용이 정리된 클래스
*/
class CallAPI {
    
    /**
     # (E) path
     - Author: Mephrine
     - Date: 20.06.10
     - Note: 사용되는 API Path와 관련 정보
    */
    fileprivate enum path {
        case main
        
        // PathURL
        fileprivate var pathURL: String? {
            if let path = Bundle.main.path(forResource: "Musinsa", ofType: "json") {
                return path
            }
            return nil
        }
    }
    
    /**
     # (E) APIError
     - Author: Mephrine
     - Date: 20.06.10
     - Note: API Error 정보
    */
    enum APIError: Error {
        case erroURL
        case noData
        case network
        case none
        
        var desc: String? {
            switch self {
            case .erroURL:
                return STR_NETWORK_ERROR_URL
            case .noData:
                return STR_NETWORK_NO_DATA
            case .network:
                return STR_NETWORK_CONNECT_ERROR
            case .none:
                return ""
            }
        }
    }
    
    static let shared: CallAPI = CallAPI()
    
    // MARK: - API List
    /**
     # mainData
     - Author: Mephrine
     - Date: 20.06.10
     - Parameters:
        - completeion : 결과값 Closure
     - Returns:
     - Note: Dummy Json 메인 데이터 조회
    */
    func mainData(_ completion: @escaping (Result<MainData, APIError>) -> Void) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path.main.pathURL!), options: .mappedIfSafe)
            if let mainData = data.decode(MainData.self) {
                completion(.success(mainData))
                return
            }
            
            completion(.failure(.erroURL))
        } catch let error {
            p("path error : \(error.localizedDescription)")
            completion(.failure(.erroURL))
        }
    }
}
