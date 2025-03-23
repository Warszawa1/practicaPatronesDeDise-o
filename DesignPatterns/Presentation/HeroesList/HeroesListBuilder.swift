//
//  HeroesListBuilder.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

import UIKit

final class HeroesListBuilder {
    func build() -> UIViewController {
        let useCase = GetHeroesUseCase()
        let viewModel = HeroesListViewModel(useCase: useCase)
        
        let controller = UINavigationController(rootViewController: UIViewController())
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}
