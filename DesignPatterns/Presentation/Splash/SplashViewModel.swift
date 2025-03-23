//
//  SplashViewModel.swift
//  DesignPatterns
//
//  Created by Ire  Av on 19/3/25.
//

import Foundation

enum SplashState: Equatable{
    case loading
    
    case error
    
    case ready
}

final class SplashViewModel {
    var onStateChange = Binding<SplashState>()
    
    func load() {
        onStateChange.update(.loading)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3 ) { [weak self] in
                self?.onStateChange.update(.ready)
        }
    }
}


