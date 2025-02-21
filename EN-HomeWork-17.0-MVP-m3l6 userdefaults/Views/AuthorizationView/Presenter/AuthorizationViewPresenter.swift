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
    
    private var fbManager = FBManager()
    
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
        let userData = UserData(email: email, password: password, name: nil, surname: nil)
        
        // Проверка совпадения
        if email == savedEmail && password == savedPassword {
            fbManager.authUser(user: userData) { isLogin in
                if isLogin {
                    // Перемещаем на главный экран
                    NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc": VCs.main])
                } else {
                    print("error")
                }
                print(savedPassword ?? "unknown password")
                print(savedEmail ?? "unknown email")
            }
        } else {
            print("Invalid email or password. Please try again.")
        }
    }
}
