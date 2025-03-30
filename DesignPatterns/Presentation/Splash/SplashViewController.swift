//
//  SplashViewController.swift
//  DesignPatterns
//
//  Created by Ire  Av on 18/3/25.
//


import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: SplashViewModel
    private let dragonBallImageView = UIImageView()
    
    // MARK: - Initialization
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateDragonBall()
        viewModel.load()
    }
    
    // MARK: - Binding
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .ready:
                self?.navigateToLoginScreen()
            case .error(let message):
                print("Error: \(message)")
            case .loading:
                // Animation already showing loading state
                break
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set background to black
        view.backgroundColor = .black
        
        // Configure Dragon Ball image
        dragonBallImageView.image = UIImage(named: "dragonballBlackBG")
        dragonBallImageView.contentMode = .scaleAspectFit
        dragonBallImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dragonBallImageView)
        
        // Position the Dragon Ball in the center
        NSLayoutConstraint.activate([
            dragonBallImageView.widthAnchor.constraint(equalToConstant: 120),
            dragonBallImageView.heightAnchor.constraint(equalToConstant: 120),
            dragonBallImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dragonBallImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 190),
        ])
    }
    
    private func animateDragonBall() {
        // Start rotation animation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2 // Full rotation
        rotationAnimation.duration = 2.0
        rotationAnimation.repeatCount = 2 // Rotate twice
        dragonBallImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    private func navigateToLoginScreen() {
        UIView.animate(withDuration: 0.5) {
            self.dragonBallImageView.alpha = 0
        } completion: { _ in
            // Instance of LoginBuilder
            let loginBuilder = LoginBuilder()
            // Call the build method (instance)
            let loginVC = loginBuilder.build()
            // Use the full type name for the presentation style
            loginVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: false)
        }
    }
}

// Static, so no () in SplashBuilder
//#Preview {
//    SplashBuilder.build()
//}
