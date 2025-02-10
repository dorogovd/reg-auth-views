//
//  AutharizationViewController.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 07.12.2024.
//

import UIKit

protocol AuthorizationViewProtocol: AnyObject {
   
}

class AuthorizationView: UIViewController, AuthorizationViewProtocol {
    
    var presenter: AuthorizationViewPresenterProtocol!

    private lazy var titleLabel: UILabel = {
        $0.text = "Authorization"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var logInButton: UIButton = {
        $0.setTitle("Log in", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system, primaryAction: logInTapped))
    
    private lazy var logInTapped = UIAction { [weak self] _ in
        guard let self = self,
        let password = self.passwordTextField.text, !password.isEmpty,
        let email = self.emailTextField.text, !email.isEmpty else {
        print("One or more fields are empty")
        return
        }
        self.presenter.checkLogin(email: email, password: password)
    }

    private lazy var createAccountButton: UIButton = {
        $0.setTitle("Create account", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system, primaryAction: createAccountTapped))
    
    private lazy var createAccountTapped = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.presenter.createAccount()
    }
    
    private func createTextField(placeholder: String, isSecureTextEntry: Bool) -> UITextField {
       let textField = UITextField()
       textField.placeholder = placeholder
       textField.isSecureTextEntry = isSecureTextEntry
       textField.borderStyle = .roundedRect
       textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
       return textField
   }
    
    private lazy var emailTextField = createTextField(placeholder: "Email", isSecureTextEntry: false)
    private lazy var passwordTextField = createTextField(placeholder: "Password", isSecureTextEntry: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(logInButton)
        view.addSubview(createAccountButton)

        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),

            createAccountButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
}
