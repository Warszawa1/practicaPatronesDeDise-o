//
//  GetHeroesUseCase.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//

import Foundation

protocol GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], Error>) -> Void)
}

final class GetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], Error>) -> Void) {
        GetHeroesAPIRequest(name: nil)
            .perform { result in
                // Con concurrencia
                do {
                    let heroes = try result.get()
                    let mapper = HeroDTOToHeroModelMapper()
                    completion(.success(heroes.map { mapper.map($0) }))
                } catch {
                    completion(.failure(error))
                }
                // Igual pero limitado por el limit de 8 casos
//                switch result {
//                case .success(let heroes):
//                    let mapper = HeroDTOToHeroModelMapper()
//                    completion(.success(heroes.map { mapper.map($0) }))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
            }
    }
}
