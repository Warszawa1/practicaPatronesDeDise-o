//
//  LoginViewModelTest.swift
//  DesignPatterns
//
//  Created by Ire  Av on 22/3/25.
//
import XCTest

// TEST ASINCRONOS TIENEN EXPECTATIVAS
// 1.En este caso nuestro estado tiene que transicionar en 2 pasos (1.login, 2.success)


// Las interfaces internas se hacen visibles SOLO para los tests
@testable import DesignPatterns

final class SuccessLoginUseCase: LoginUseCaseProtocol {
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        completion(.success(()))
    }
}

final class FailedLoginUseCase: LoginUseCaseProtocol {
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        completion(.failure(LoginError(reason: "Hello world")))
    }
}
    
final class LoginViewModelTest: XCTestCase {
    func testWhenUseCaseSuccedesStateIsSuccess() {
        let useCase = SuccessLoginUseCase()
        // System under test - sistema que estamos testeando
        let sut = LoginViewModel(useCase: useCase)
        
        // 1.*
        let loadinExpectation = expectation(description: "View is loading")
        let successExpectation = expectation(description: "View is showing")
        
        // Escuchamos al binding por detr'as
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadinExpectation.fulfill()
            } else if state == . success {
                successExpectation.fulfill()
            }
        }
        sut.login(username: "", password: "")
        // TIMEOUTS, importante no olvidarlos (money)
        wait(for: [loadinExpectation, successExpectation], timeout: 5)
    }
    
    func testWhenUseCaseFailsStateIsSuccess() {
        let useCase = FailedLoginUseCase()
        // System under test - sistema que estamos testeando
        let sut = LoginViewModel(useCase: useCase)
        
        // 1.*
        let expectedText = "Hello world"
        let loadinExpectation = expectation(description: "View is loading")
        let failureExpectation = expectation(description: "View has failed")
        
        // Escuchamos al binding por detr'as
        sut.onStateChanged.bind { state in
            switch state {
            case .loading: loadinExpectation.fulfill()
            case .error(let reason):
                XCTAssertEqual(reason, expectedText)
                failureExpectation.fulfill()
            default: break
            }
        }
        sut.login(username: "", password: "")
        // TIMEOUTS, importante no olvidarlos (CI=money)
        wait(for: [loadinExpectation, failureExpectation], timeout: 5)
    }
}
