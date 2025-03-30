//
//  GetHeroDetailUseCase.swift
//  DesignPatterns
//
//  Created by Ire  Av on 29/3/25.
//

import Foundation

protocol GetHeroDetailUseCaseProtocol {
    func run(completion: @escaping (Result<HeroModel, Error>) -> Void)
}

final class GetHeroDetailUseCase: GetHeroDetailUseCaseProtocol {
    private let heroId: String
    
    init(heroId: String) {
        self.heroId = heroId
    }
    
    func run(completion: @escaping (Result<HeroModel, Error>) -> Void) {
        // Use the existing GetHeroesAPIRequest to get all heroes
        let request = GetHeroesAPIRequest()
        
        request.perform { result in
            do {
                let heroesDTO = try result.get()
                
                // Find the hero with the matching ID
                guard let heroDTO = heroesDTO.first(where: { $0.identifier == self.heroId }) else {
                    let error = NSError(domain: "HeroDetail", code: 404, userInfo: [NSLocalizedDescriptionKey: "Hero not found"])
                    completion(.failure(error))
                    return
                }
                
                let mapper = HeroDTOToHeroModelMapper()
                let heroModel = mapper.map(heroDTO)
                completion(.success(heroModel))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
