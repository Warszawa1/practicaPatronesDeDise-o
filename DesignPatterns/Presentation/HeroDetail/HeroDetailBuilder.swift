//
//  HeroDetailBuilder.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

import Foundation

final class HeroDetailBuilder {
    static func build(with heroId: String) -> HeroDetailViewController {
        let useCase = GetHeroDetailUseCase(heroId: heroId)
        let viewModel = HeroDetailViewModel(useCase: useCase)
        let viewController = HeroDetailViewController(viewModel: viewModel)
        return viewController
    }
}

