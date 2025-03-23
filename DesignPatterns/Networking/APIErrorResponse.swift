//
//  APIErrorResponse.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//

import Foundation

struct APIErrorResponse: Error, Equatable {
    let url: String
    let statusCode: Int
    let data: Data?
    let message: String
    
    init(url: String, statusCode: Int, data: Data? = nil, message: String) {
        self.url = url
        self.statusCode = statusCode
        self.data = data
        self.message = message
    }
}

extension APIErrorResponse {
    static func malformedURL(_ url: String) -> APIErrorResponse {
        return APIErrorResponse(url: url, statusCode: -5, message: "Malformed URL")
    }
    
    static func empty(_ url: String) -> APIErrorResponse {
        return APIErrorResponse(url: url, statusCode: -4, message: "Empty data")
    }
    
    static func unknown(_ url: String) -> APIErrorResponse {
        return APIErrorResponse(url: url, statusCode: -3, message: "Unknown error")
    }
    
    static func parseData(_ url: String) -> APIErrorResponse {
        return APIErrorResponse(url: url, statusCode: -2, message: "Cannot parse data from URL")
    }
    
    static func network(_ url: String) -> APIErrorResponse {
        return APIErrorResponse(url: url, statusCode: -1, message: "Network connection error")
    }
}


// Better practice when working with status codes*
//struct APIErrorCodes {
//    static let MALFORMED_URL = -5
//    static let EMPTY = -4
//    static let UNKNOWN = -3
//    static let PARSE_DATA = -2
//    static let NETWORK = -1
//}
