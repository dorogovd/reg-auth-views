//
//  MainViewPresenter.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 08.12.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol MainViewPresenterProtocol: AnyObject {
    func logOut()
    func updateUserName(completion: @escaping (String) -> Void)
    func getUserName() -> String?
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    private var fbManager = FBManager()
    
    init(view: MainViewProtocol?) {
        self.view = view
    }
    
    func logOut() {
        fbManager.signOut()
        NotificationCenter.default.post(name: .changeRootViewController, object: nil, userInfo: ["vc": VCs.authorization])
    }
    
    func getUserName() -> String? {
                let name = UserDefaults.standard.string(forKey: "name") ?? "Unknown"
                let surname = UserDefaults.standard.string(forKey: "surname") ?? "User"
                return "\(name) \(surname)"
    }
    
    func updateUserName(completion: @escaping (String) -> Void) {
        // Получаем UID текущего пользователя (убедись, что FirebaseApp настроен, и пользователь авторизован)
        guard let uid = Auth.auth().currentUser?.uid else {
            completion("Unknown User")
            return
        }
        // Выполняем запрос к Firestore для получения данных пользователя
        Firestore.firestore().collection("users").document(uid).getDocument { data, error in
            if let error = error {
                print("error: \(error)")
                completion("Unknown User")
                return
            }
            
            let data = data?.data()
            let name = data?["name"] as? String ?? "Unknown"
            let surname = data?["surname"] as? String ?? "User"
            completion("\(name) \(surname)")
        }
    }
}
