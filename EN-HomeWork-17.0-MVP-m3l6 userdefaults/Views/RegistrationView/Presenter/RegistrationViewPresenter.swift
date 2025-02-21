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
    var email: String? { get }
    func logIn()
    func regUser(name: String, surname: String, email: String, password: String, isRegistered: Bool)
}

class RegistrationViewPresenter: RegistrationViewPresenterProtocol {
    
    weak var view: RegistrationViewProtocol?
    
    let keychain = KeychainSwift()
    
    private var fbManager = FBManager()
    
    
    var name = UserDefaults.standard.string(forKey: "name")
    var surname = UserDefaults.standard.string(forKey: "surname")
    var isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
    var email = UserDefaults.standard.string(forKey: "email")
    
    init(view: RegistrationViewProtocol?) {
        self.view = view
    }
    
    func logIn() {
        NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc":VCs.authorization])
    }
    
    func regUser(name: String, surname: String, email: String, password: String, isRegistered: Bool) {
        let user = UserData(email: email, password: password, name: name, surname: surname)
        fbManager.regUser(user: user) { isLogin in
            if isLogin {
                        UserDefaults.standard.set(name, forKey: "name")
                        UserDefaults.standard.set(surname, forKey: "surname")
                        UserDefaults.standard.set(email, forKey: "email")
                        self.keychain.set(password, forKey: "password")
                        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
                
                        NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc": VCs.main])
            } else {
                print("error")
            }
        }
    }
}

extension Notification.Name {
    static let changeRootViewController = Notification.Name("changeRootViewController")
}
