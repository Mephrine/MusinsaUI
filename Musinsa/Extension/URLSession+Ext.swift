//
//  URLSession+Ext.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

extension URLSession {
    /**
        # load<T>
        - Author: Mephrine
        - Date: 20.06.10
        - Parameters:
        - Returns: T?
        - Note: dataTask 결과 값을 반환
        */
    func load<T>(_ api: API<T>, completion: @escaping (T?, Bool) -> Void) {
        dataTask(with: api.request) { data, response, error in
            
            // 에러 확인
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil else {
                p("load api error : response or statusCode")
                completion(nil, false)
                return
            }
            
            completion(data.flatMap(api.data), true)
        }.resume()
    }
}
