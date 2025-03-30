//
//  HeroDetailViewModelTests.swift
//  DesignPatterns
//
//  Created by Ire  Av on 29/3/25.
//

import XCTest
@testable import DesignPatterns

// Mock success use case
private final class SuccessGetHeroDetailUseCase: GetHeroDetailUseCaseProtocol {
    func run(completion: @escaping (Result<HeroModel, Error>) -> Void) {
        let hero = HeroModel(
            identifier: "test_id",
            name: "Test Hero",
            description: "Test Description",
            photo: "https://test.com/photo.jpg",
            favorite: true
        )
        completion(.success(hero))
    }
}

// Mock failure use case
private final class FailureGetHeroDetailUseCase: GetHeroDetailUseCaseProtocol {
    func run(completion: @escaping (Result<HeroModel, Error>) -> Void) {
        struct CustomError: Error, LocalizedError {
            let errorDescription: String
            
            init(_ message: String) {
                self.errorDescription = message
            }
        }
        completion(.failure(CustomError("Failed to fetch hero details")))
    }
}

final class HeroDetailViewModelTests: XCTestCase {
    func testWhenUseCaseSucceedsStateIsLoaded() {
        // Arrange
        let useCase = SuccessGetHeroDetailUseCase()
        let sut = HeroDetailViewModel(useCase: useCase)
        
        let loadingExpectation = expectation(description: "Loading state")
        let loadedExpectation = expectation(description: "Loaded state")
        
        var states: [HeroDetailViewModel.State] = []
        
        // Act
        sut.onStateChanged.bind { state in
            states.append(state)
            
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .loaded:
                loadedExpectation.fulfill()
            default:
                break
            }
        }
        
        sut.loadHeroDetail()
        
        // Assert
        wait(for: [loadingExpectation, loadedExpectation], timeout: 1.0)
        
        XCTAssertEqual(states.count, 2)
        XCTAssertEqual(states[0], .loading)
        XCTAssertEqual(states[1], .loaded)
        XCTAssertEqual(sut.name, "Test Hero")
        XCTAssertEqual(sut.description, "Test Description")
        XCTAssertEqual(sut.photoURL, "https://test.com/photo.jpg")
    }
    
    func testWhenUseCaseFailsStateIsError() {
        // Arrange
        let useCase = FailureGetHeroDetailUseCase()
        let sut = HeroDetailViewModel(useCase: useCase)
        
        let loadingExpectation = expectation(description: "Loading state")
        let errorExpectation = expectation(description: "Error state")
        
        var states: [HeroDetailViewModel.State] = []
        var receivedErrorMessage: String?
        
        // Act
        sut.onStateChanged.bind { state in
            states.append(state)
            
            switch state {
            case .loading:
                loadingExpectation.fulfill()
            case .error(let message):
                receivedErrorMessage = message
                errorExpectation.fulfill()
            default:
                break
            }
        }
        
        sut.loadHeroDetail()
        
        // Assert
        wait(for: [loadingExpectation, errorExpectation], timeout: 1.0)
        
        XCTAssertEqual(states.count, 2)
        XCTAssertEqual(states[0], .loading)
        
        if case .error = states[1] {
            // Verify we got an error state
            XCTAssertTrue(true)
        } else {
            XCTFail("Second state should be error")
        }
        
        XCTAssertEqual(receivedErrorMessage, "Failed to fetch hero details")
        XCTAssertEqual(sut.name, "")
        XCTAssertEqual(sut.description, "")
        XCTAssertEqual(sut.photoURL, "")
    }
    
    func testGetTitleReturnsHeroNameWhenLoaded() {
        // Arrange
        let useCase = SuccessGetHeroDetailUseCase()
        let sut = HeroDetailViewModel(useCase: useCase)
        
        let loadedExpectation = expectation(description: "Loaded state")
        
        // Act
        sut.onStateChanged.bind { state in
            if case .loaded = state {
                loadedExpectation.fulfill()
            }
        }
        
        sut.loadHeroDetail()
        
        // Assert
        wait(for: [loadedExpectation], timeout: 1.0)
        XCTAssertEqual(sut.getTitle(), "Test Hero")
    }
    
    func testGetTitleReturnsDefaultWhenNotLoaded() {
        // Arrange
        let useCase = FailureGetHeroDetailUseCase()
        let sut = HeroDetailViewModel(useCase: useCase)
        
        // Act & Assert
        XCTAssertEqual(sut.getTitle(), "Hero Detail")
    }
}
