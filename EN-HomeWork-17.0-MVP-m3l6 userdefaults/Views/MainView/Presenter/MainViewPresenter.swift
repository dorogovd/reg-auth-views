//
//  MainViewPresenter.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 08.12.2024.
//

import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    func logOut()
    func getUserName() -> String
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    init(view: MainViewProtocol?) {
        self.view = view
    }
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: "isLogin")
        NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc": VCs.authorization])
    }
    
    func getUserName() -> String {
        let name = UserDefaults.standard.string(forKey: "name") ?? "Unknown"
        let surname = UserDefaults.standard.string(forKey: "surname") ?? "User"
        return "\(name) \(surname)"
    }
}
