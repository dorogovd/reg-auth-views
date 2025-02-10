//
//  AuthorizationViewPresenter.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 07.12.2024.
//

import UIKit
import KeychainSwift

protocol AuthorizationViewPresenterProtocol: AnyObject {
    func createAccount()
    func checkLogin(email: String, password: String)
}

class AuthorizationViewPresenter: AuthorizationViewPresenterProtocol {
    
    weak var view: AuthorizationViewProtocol?
    
    let keychain = KeychainSwift()
    
    init(view: AuthorizationViewProtocol?) {
        self.view = view
    }
    
    func createAccount() {
        NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc": VCs.registration])
    }
    
    func checkLogin(email: String, password: String) {
        // Получение сохранённых значений из UserDefaults и Keychain
        let savedEmail = UserDefaults.standard.string(forKey: "email")
        let savedPassword = keychain.get("password")
        
        // Проверка совпадения
        if email == savedEmail && password == savedPassword {
            // Перемещаем на главный экран
            UserDefaults.standard.set(true, forKey: "isLogin") // Сохраняем статус логина
            NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc": VCs.main])
        } else {
            // Сообщаем об ошибке через протокол
            print("Invalid email or password. Please try again.")
        }
        print(savedPassword)
        print(savedEmail)
    }
}
