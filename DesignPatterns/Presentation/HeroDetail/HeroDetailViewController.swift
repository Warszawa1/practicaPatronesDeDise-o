//
//  HeroDetailViewController.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

import UIKit

final class HeroDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: HeroDetailViewModel
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let heroImageView = AsyncImage()  // Use AsyncImage instead of UIImageView
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: - Initialization
    init(viewModel: HeroDetailViewModel) {
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
        configureWithViewModel()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = viewModel.getTitle()
        view.backgroundColor = .white
        
        // Set up la vista scroll
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Crear el container
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cardView)
        
        // Set up card view constraints with margins
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        // Set up image view inside card
        cardView.addSubview(heroImageView)
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        // Set up name label inside card
        cardView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20)
        ])
        
        // Set up description label inside card
        cardView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24)
        ])
    }
    
    private func configureWithViewModel() {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        
        // AsyncImage's setImage method
        heroImageView.setImage(viewModel.photoURL)
    }
}
