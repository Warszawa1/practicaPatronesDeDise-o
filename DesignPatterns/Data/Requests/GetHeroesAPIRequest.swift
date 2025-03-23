//
//  GetHeroesAPIRequest.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//

//SWAGGER es el contrato que nos manda API

import Foundation

struct GetHeroesAPIRequest: HTTPRequest {
    typealias Response = [HeroDTO]
    
    let method: Methods = .POST
    let path: String = "/api/heros/all"
    let body: (any Encodable)?
    
    init(name: String = "") {
        // funcion de alto nivel que nos dan los opcionales
        //solo se llama cuando hay un valor dentro de name
        body = RequestDTO(name: name)
          // easier version*
//        if let name {
//            body = RequestDTO(name: name)
//        } else {
//            body = nil
//        }
    }
}

private extension GetHeroesAPIRequest {
    struct RequestDTO: Codable {
        let name: String
    }
}
