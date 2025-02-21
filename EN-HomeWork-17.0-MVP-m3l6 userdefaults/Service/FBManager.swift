//
//  FBManager.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 11.02.2025.
//

import Firebase
import FirebaseAuth

class FBManager {
    func regUser(user: UserData, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else {
                print(error!)
                completion(false)
                return
            }
            
            let uid = result?.user.uid
            setUserData(name: user.name, surname: user.surname, email: user.email, uid: uid!)
            completion(true)
        }
    }
    
    private func setUserData(name: String?, surname: String?, email: String?, uid: String) {
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .setData(["name":name ?? "", "surname": surname ?? "", "email":email ?? ""])
    }
    
    func authUser(user: UserData, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { responce, error in
            guard error == nil else {
                print(error!)
                completion(false)
                return
            }
            guard let _ = responce?.user.uid else {
                completion(false)
                return }
            completion(true)
        }
    }
    
    func signOut() {
        do
        {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isLogin() -> Bool { // проверка исЛогин вместо через файрбейс вместо юзердефолтс
        if let _ = Auth.auth().currentUser {
            return true
        } else {
            return false
        }
    }
}

struct UserData {
    let email: String
    let password: String
    let name: String?
    let surname: String?
}
