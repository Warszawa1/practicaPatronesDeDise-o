//
//  LoginBuilder.swift
//  DesignPatterns
//
//  Created by Ire  Av on 19/3/25.
//

import UIKit

// EL build nunca tiene parametros ( si un parametro es obligatorio va en el inizializador del builder, si es opcional o tiene un valor por defecto va con un setter.

final class LoginBuilder {
    func build() -> UIViewController {
        let useCase = LoginUseCase(dataSource: SessionDataSource.shared)
        let viewModel = LoginViewModel(useCase: useCase)
        let controller = LoginViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
}
