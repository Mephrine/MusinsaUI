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
        
        // URL
        private var strUrl: String {
            switch self {
            case .main:
                return "/Dummy/Musinsa.json"
            }
        }
        
        // 파라미터
        private var parameters: [String: Any]? {
            return nil
        }
        
        // PathURL
        fileprivate var pathURL: String {
            return "\(strUrl)"
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
        guard let url = URL(string: path.main.pathURL) else {
            p("getCurrentWeather error")
            DispatchQueue.main.async {
                completion(.failure(.erroURL))
            }
            return
        }
        
        let loadAPI = API<MainData>(url)
        session.load(loadAPI) { resultData, success in
            if !success {
                DispatchQueue.main.async {
                    completion(.failure(.network))
                }
                return
            }
            
            guard let data = resultData else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
}

/**
 # (S) API<T>.swift
 - Author: Mephrine
 - Date: 20.05.28
 - Note: request 후 전달한 형식의 data를 받기 위해 사용하는 구조체
*/
struct API<T> {
    var request: URLRequest
    let data: (Data) -> T?
}

extension API where T: Decodable {
    init(_ url: URL) {
        self.request = URLRequest(url: url)
        self.data = {
            try? JSONDecoder().decode(T.self, from: $0)
        }
    }
}
