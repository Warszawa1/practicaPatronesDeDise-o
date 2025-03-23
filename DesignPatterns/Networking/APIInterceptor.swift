//
//  APIInterceptor.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//

import Foundation

protocol APIInterceptor { /* Common protocol for Request and Response interceptors */

}

protocol APIRequestInterceptor: APIInterceptor {
    func intercept(_ request: URLRequest) -> URLRequest
}

// AuthenticationAPIInterceptor

final class AuthenticationAPIInterceptor: APIRequestInterceptor {
    private let dataSource: SessionDataSourceProtocol
    
    init(dataSource: SessionDataSourceProtocol = SessionDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func intercept(_ request: URLRequest) -> URLRequest {
        print(">>> Intercepting request to: \(request.url?.absoluteString ?? "unknown")")
        
        guard let session = dataSource.getSession() else {
            print(">>> No session data available!")
            return request
        }
        
        let token = String(decoding: session, as: UTF8.self)
        print(">>> Adding token: \(token)")
        
        var copy = request
        copy.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return copy
    }
}
