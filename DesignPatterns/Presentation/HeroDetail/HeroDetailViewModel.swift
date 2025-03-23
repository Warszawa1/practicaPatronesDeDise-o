//
//  HeroDetailViewModel.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

final class HeroDetailViewModel {
    private let hero: HeroModel
    
    // Public properties for the view
    let name: String
    let description: String
    let photoURL: String
    let identifier: String
    
    init(hero: HeroModel) {
        self.hero = hero
        self.identifier = hero.identifier
        self.name = hero.name
        self.description = hero.description
        self.photoURL = hero.photo
    }
    
    func getTitle() -> String {
        return hero.name
    }
}
