//
//  GetHeroDetailAPIRequest.swift
//  DesignPatterns
//
//  Created by Ire  Av on 29/3/25.
//
import Foundation

struct GetHeroDetailAPIRequest: HTTPRequest {
    typealias Response = [HeroDTO]  // Note: This returns an array, but we'll take the first match
    
    let method: Methods = .POST
    let path: String = "/api/heros/all"
    let body: (any Encodable)?
    
    init(heroId: String) {
        self.body = RequestDTO(id: heroId)
    }
}

private extension GetHeroDetailAPIRequest {
    struct RequestDTO: Codable {
        let id: String
    }
}
