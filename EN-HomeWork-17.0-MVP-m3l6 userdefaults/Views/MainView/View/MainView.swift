//
//  MainView.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 08.12.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
}

class MainView: UIViewController, MainViewProtocol {
    
    var presenter: MainViewPresenterProtocol!
    
    private lazy var titleLabel: UILabel = {
        $0.text = presenter.getUserName()
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var logOutButton: UIButton = {
        $0.setTitle("Log out", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system, primaryAction: logOutTapped))
    
    private lazy var logOutTapped = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.presenter.logOut()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        // Запрашиваем имя пользователя и обновляем label
        presenter.updateUserName { [weak self] fullName in
            DispatchQueue.main.async {
                self?.titleLabel.text = fullName
            }
        }
    }
    
    

    private func setupUI() {
        
        view.addSubview(titleLabel)
        view.addSubview(logOutButton)

        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
}
