//
//  HeroModel.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//


// Transforma el HeroDTO a un modelo de dominio, si en un futuro cambia el API los cambios necesarios son + sencillos

struct HeroModel: Equatable {
    let identifier: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
}
