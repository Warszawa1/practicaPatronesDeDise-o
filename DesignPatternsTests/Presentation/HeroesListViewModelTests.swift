//
//  HeroesListViewModelTests.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

import XCTest

@testable import DesignPatterns

private extension HeroModel {
    static let dummyObject = HeroModel(identifier: "1", name: "Test", description: "Test", photo: "Test", favorite: false)
}

private final class SuccessGetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], any Error>) -> Void) {
        completion(.success([.dummyObject]))
    }
}

private final class FailedGetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], any Error>) -> Void) {
        struct CustomError: Error {
            let reason: String
        }
        completion(.failure(CustomError(reason: "Network error")))
    }
}

final class HeroesListViewModelTests: XCTestCase {
    func testWhenUseCaseSucceedsStateIsSuccess() {
        let useCase = SuccessGetHeroesUseCase()
        let sut = HeroesListViewModel(useCase: useCase)
        
        let successExpectation = expectation(description: "Success scenario")
        sut.onStateChanged.bind { state in
            if state == .success {
                successExpectation.fulfill()
            }
        }
        sut.loadHeroes()
        wait(for: [successExpectation], timeout: 3)
        XCTAssertEqual(sut.heroes, [.dummyObject])
    }
    
    func testWhenUseCaseFailsStateIsError() {
        let useCase = FailedGetHeroesUseCase()
        let sut = HeroesListViewModel(useCase: useCase)
        
        let errorExpectation = expectation(description: "Error scenario")
        var receivedErrorReason: String?
        
        sut.onStateChanged.bind { state in
            if case .error(let reason) = state {
                receivedErrorReason = reason
                errorExpectation.fulfill()
            }
        }
        
        sut.loadHeroes()
        wait(for: [errorExpectation], timeout: 3)
        
        XCTAssertEqual(receivedErrorReason, "Datos no disponibles")
        XCTAssertTrue(sut.heroes.isEmpty)
    }
}
