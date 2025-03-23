//
//  APISession.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//

import Foundation

protocol APISessionContract {
    func request<Request: HTTPRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void)
}

struct APISession: APISessionContract {
    static var shared: APISessionContract = APISession()
    
    private let session: URLSession // Changed from type to property
    private let requestInterceptors: [APIRequestInterceptor]
    
    init(configuration: URLSessionConfiguration = .default,
         requestInterceptors: [APIRequestInterceptor] = [AuthenticationAPIInterceptor()]) {
        self.requestInterceptors = requestInterceptors
        self.session = URLSession(configuration: configuration)
    }
    
    func request<Request: HTTPRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            var request = try apiRequest.getRequest()
            requestInterceptors.forEach { request = $0.intercept(request)}
            // Datatask no inicia la operación, la hace disponible para que se use en algún momento
            session.dataTask(with: request) { data, response, error in
                if let error {
                    return completion(.failure(error))
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(APIErrorResponse.network(apiRequest.path)))
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    return completion(.success(data ?? Data()))
                default:
                    return completion(.failure(APIErrorResponse.network(apiRequest.path)))
                }
                
            }.resume() // realmente arranca la operación provided by dataTask ******************************
        } catch {
            completion(.failure(error))
        }
    }
}
