//
//  SplashViewController.swift
//  DesignPatterns
//
//  Created by Ire  Av on 18/3/25.
//


import UIKit

final class SplashViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let viewModel: SplashViewModel
    
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SplashView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }
    
    // MARK: - Binding
    private func bind() {
        viewModel.onStateChange.bind { [weak self] state in
            switch state {
            case .loading:
                self?.setAnimation(true)
            case .error:
                print("finished")
                self?.setAnimation(false)
            case .ready:
                self?.setAnimation(false)
                self?.present(LoginBuilder().build(), animated: true)
            }
        }
    }
    
    
    
    // MARK: - UI operations
    private func setAnimation(_ animating: Bool) {
        switch activityIndicator.isAnimating {
        case true where !animating:
            activityIndicator.stopAnimating()
        case false where animating:
            activityIndicator.startAnimating()
        default: break
        }
    }
}

#Preview {
    SplashBuilder().build()
}
