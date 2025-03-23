//
//  HeroesListViewController.swift
//  DesignPatterns
//
//  Created by Ire  Av on 23/3/25.
//

import UIKit

class HeroesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorStackView: UIStackView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    
    private let viewModel: HeroesListViewModel
    init(viewModel: HeroesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroesListView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print(">>> HeroesListViewController viewDidLoad called")
        super.viewDidLoad()
        bind()
        viewModel.loadHeroes()
        tableView.delegate = self
        tableView.dataSource = self
        // Add this to viewDidLoad
        if let sessionData = SessionDataSource.shared.getSession() {
            print(">>> Session exists: \(String(decoding: sessionData, as: UTF8.self))")
        } else {
            print(">>> No session exists! Need to login first.")
        }
        tableView.register(UINib(nibName: "HeroCell", bundle: Bundle(for: type(of: self))),
                           forCellReuseIdentifier: HeroCell.reuseIdentifier)
    }
    
    @IBAction func onRetryButtonTapped(_ sender: Any) {
        viewModel.loadHeroes()
    }
    
    // MARK: - Binding
    private func bind() {
        print(">>> Setting up binding")
        viewModel.onStateChanged.bind { [weak self] state in
            print(">>> State changed to: \(state)")
            switch state {
            case .error(reason: let reason):
                print(">>> Error state: \(reason)")
                self?.renderError(reason)
            case .loading:
                print(">>> Loading state")
                self?.renderLoading()
            case .success:
                print(">>> Success state with \(self?.viewModel.heroes.count ?? 0) heroes")
                self?.renderSuccess()
            }
        }
    }
    
    // MARK: - State rendering
    private func renderError(_ reason: String) {
        errorLabel.text = reason
        errorStackView.isHidden = false
        activityIndicator.stopAnimating()
    }
    private func renderLoading() {
        errorStackView.isHidden = true
        activityIndicator.startAnimating()
    }
    private func renderSuccess() {
        errorStackView.isHidden = true
        activityIndicator.stopAnimating()
        print("Heroes loaded: \(viewModel.heroes.count)")

        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource conformance
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.heroes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        HeroCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.reuseIdentifier)
        if let cell = cell as? HeroCell {
            let hero = viewModel.heroes[indexPath.row]
            cell.setData(name: hero.name, photo: hero.photo)
            cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white // Temporary to see cells
        }
        return cell ?? UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Navigate to detail ***
        let selectedHero = viewModel.heroes[indexPath.row]
        let detailVC = HeroDetailBuilder.build(with: selectedHero)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

