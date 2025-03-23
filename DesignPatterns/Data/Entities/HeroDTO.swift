//
//  HeroEntity.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//

// DTO (data transfer object)

struct HeroDTO: Codable {
    let identifier: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
    
    enum CodinKeys: String, CodingKey {
        case identifier = "id"
        case name
        case description
        case photo
        case favorite
    }
}
