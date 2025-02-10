//
//  RegistrationViewPresenter.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 07.12.2024.
//

import UIKit
import KeychainSwift

protocol RegistrationViewPresenterProtocol: AnyObject {
    var name: String? { get }
    var surname: String? { get }
    var isRegistered: Bool { get }
    var isLogin: Bool { get }
    var email: String? { get }
   // var password: String? { get }
    func saveRegistrationData(name: String, surname: String, email: String, password: String, isRegistered: Bool, isLogin: Bool)
    func logIn()
}

class RegistrationViewPresenter: RegistrationViewPresenterProtocol {
    
    weak var view: RegistrationViewProtocol?
    
    let keychain = KeychainSwift()
    
    var name = UserDefaults.standard.string(forKey: "name")
    var surname = UserDefaults.standard.string(forKey: "surname")
    var isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
    var isLogin = UserDefaults.standard.bool(forKey: "isLogin")
    var email = UserDefaults.standard.string(forKey: "email")
    
    init(view: RegistrationViewProtocol?) {
        self.view = view
    }
    
    func logIn() {
        NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc":VCs.authorization])
    }
    
    func saveRegistrationData(name: String, surname: String, email: String, password: String, isRegistered: Bool, isLogin: Bool) {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(surname, forKey: "surname")
        UserDefaults.standard.set(email, forKey: "email")
        keychain.set(password, forKey: "password")
        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
        UserDefaults.standard.set(isLogin, forKey: "isLogin")
        
        NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc": VCs.main])
    }
}

extension Notification.Name {
    static let changeRootViewController = Notification.Name("changeRootViewController")
}
