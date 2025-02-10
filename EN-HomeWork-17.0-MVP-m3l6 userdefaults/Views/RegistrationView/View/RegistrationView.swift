//
//  ViewController.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 07.12.2024.
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    
}

class RegistrationView: UIViewController, RegistrationViewProtocol, UITextFieldDelegate {
    
    var presenter: RegistrationViewPresenterProtocol!
    
    private lazy var titleLabel: UILabel = {
        $0.text = "Registration"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var registerButton: UIButton = {
        $0.setTitle("Registration", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system, primaryAction: registerButtonAction))
    
    private lazy var registerButtonAction = UIAction { [weak self] _ in
        guard let self = self,
                 let password = self.passwordTextField.text, !password.isEmpty,
                 let name = self.nameTextField.text, !name.isEmpty,
                 let surname = self.surnameTextField.text, !surname.isEmpty,
                 let email = self.emailTextField.text, !email.isEmpty else {
               print("One or more fields are empty")
               return
           }
        
        self.presenter.saveRegistrationData(
            name: name,
            surname: surname,
            email: email,
            password: password,
            isRegistered: true,
            isLogin: true
        )
        print(self.presenter.name)
    }

    private lazy var loginButton: UIButton = {
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system, primaryAction: logInTapped))
    
    private lazy var logInTapped = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.presenter.logIn()
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
    private lazy var nameTextField = createTextField(placeholder: "Name", isSecureTextEntry: false)
    private lazy var surnameTextField = createTextField(placeholder: "Surname", isSecureTextEntry: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(registerButton)
        view.addSubview(loginButton)

        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, nameTextField, surnameTextField])
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

            registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registerButton.heightAnchor.constraint(equalToConstant: 50),

            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
}


