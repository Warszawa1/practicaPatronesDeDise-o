//
//  SessionDataSource.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//

import Foundation

protocol SessionDataSourceProtocol {
    // almacenas y obtienes info, 2 methods
    func storeSession(_ session: Data?)
    func getSession() -> Data?
}

final class SessionDataSource: SessionDataSourceProtocol {
    static let shared: SessionDataSourceProtocol = SessionDataSource()
    
    private var token: Data?
    
    func storeSession(_ session: Data?) {
        self.token = session
    }
    func getSession() -> Data? {
        return self.token
    }
}
