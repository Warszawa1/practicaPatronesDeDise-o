//
//  HeroDetailBuilder.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

final class HeroDetailBuilder {
    static func build(with hero: HeroModel) -> HeroDetailViewController {
        let viewModel = HeroDetailViewModel(hero: hero)
        let viewController = HeroDetailViewController(viewModel: viewModel)
        return viewController
    }
}

