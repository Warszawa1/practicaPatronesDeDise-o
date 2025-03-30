//
//  SplashBuilder.swift
//  DesignPatterns
//
//  Created by Ire  Av on 18/3/25.
//

import UIKit


class SplashBuilder {
    static func build() -> SplashViewController {
        let viewModel = SplashViewModel()
        return SplashViewController(viewModel: viewModel)
    }
}
