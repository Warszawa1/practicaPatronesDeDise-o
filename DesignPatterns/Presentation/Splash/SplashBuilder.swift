//
//  SplashBuilder.swift
//  DesignPatterns
//
//  Created by Ire  Av on 18/3/25.
//

import UIKit


final class SplashBuilder {
    func build() -> UIViewController {
        let viewModel = SplashViewModel()
        return SplashViewController(viewModel: viewModel)
    }
}
