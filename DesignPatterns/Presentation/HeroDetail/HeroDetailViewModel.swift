//
//  HeroDetailViewModel.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//
import Foundation


final class HeroDetailViewModel {
    // State enum for UI state management
    enum State: Equatable {
        case loading
        case loaded
        case error(String)
    }
    
    // Binding mechanism
    let onStateChanged = Binding<State>()
    
    // Private properties
    private let useCase: GetHeroDetailUseCaseProtocol
    private(set) var hero: HeroModel?
    
    // Public computed properties
    var name: String { hero?.name ?? "" }
    var description: String { hero?.description ?? "" }
    var photoURL: String { hero?.photo ?? "" }
    
    // Initialization with UseCase
    init(useCase: GetHeroDetailUseCaseProtocol) {
        self.useCase = useCase
        self.hero = nil
    }
    
    // Load hero details from use case
    func loadHeroDetail() {
        onStateChanged.update(.loading)
        
        useCase.run { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let hero):
                self.hero = hero
                self.onStateChanged.update(.loaded)
            case .failure(let error):
                self.onStateChanged.update(.error(error.localizedDescription))
            }
        }
    }
    
    func getTitle() -> String {
        return hero?.name ?? "Hero Detail"
    }
}
