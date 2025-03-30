//
//  SplashViewModel.swift
//  DesignPatterns
//
//  Created by Ire  Av on 19/3/25.
//

import Foundation

final class SplashViewModel {
    enum State: Equatable {
        case loading
        case ready
        case error(String)
    }
    
    let onStateChanged = Binding<State>()
    
    func load() {
        onStateChanged.update(.loading)
        
        // Simulate loading time to match animation duration
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [weak self] in
            self?.onStateChanged.update(.ready)
        }
    }
}

