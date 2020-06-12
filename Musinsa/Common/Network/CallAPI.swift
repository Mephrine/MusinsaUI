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
 - Date: 20.05.28
 - Note: 네트워크 통신 관련된 내용이 정리된 클래스
*/
class CallAPI {
    
    /**
     # (E) path
     - Author: Mephrine
     - Date: 20.05.28
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
     - Date: 20.05.28
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
    
    private var session: URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = SESSION_TIME_OUT
        config.timeoutIntervalForResource = SESSION_TIME_OUT
        return URLSession(configuration: config)
    }
        
    
    // MARK: - API List
    /**
     # getCurrentWeather
     - Author: Mephrine
     - Date: 20.05.28
     - Parameters:
        - lat : 위도
        - lon : 경도
        - completeion : 결과값 Closure
     - Returns:
     - Note: 현재 날씨 API 조회 및 결과값 반환
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
