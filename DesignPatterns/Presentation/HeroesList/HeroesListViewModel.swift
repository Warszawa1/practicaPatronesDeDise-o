//
//  HeroesListViewModel.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

import Foundation

enum HeroesListState: Equatable {
    case error(reason: String)
    case loading
    case success
}

final class HeroesListViewModel {
    // Binding para no tener que preocuparnos por que hilo estamos pasando los eventos, siempre en main thread
    let onStateChanged = Binding<HeroesListState>()
    // Protocol para invertir la dependencia en un futuro
    private let useCase: GetHeroesUseCaseProtocol
    private(set) var heroes: [HeroModel] = []
    
    init(useCase: GetHeroesUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loadHeroes() {
        onStateChanged.update(.loading)
        useCase.run { [weak self] result in
            do {
                self?.heroes = try result.get()
                self?.onStateChanged.update(.success)
            } catch {
                self?.onStateChanged.update(.error(reason: "Datos no disponibles"))
            }
        }
    }
}
