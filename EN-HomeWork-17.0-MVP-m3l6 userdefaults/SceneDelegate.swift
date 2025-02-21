//
//  SceneDelegate.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 07.12.2024.
//

import UIKit

enum VCs {
    case registration
    case authorization
    case main
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let fbManager = FBManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
        let initialViewController: UIViewController
        
        if fbManager.isLogin() {
            initialViewController = Builder.createMainView()
        } else if isRegistered {
            initialViewController = Builder.createAuthorizationView()
        } else {
            initialViewController = Builder.createRegistrationView()
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setVC(_:)), name: .changeRootViewController, object: nil)
    }
    
    @objc func setVC(_ notification: Notification) {
            guard let userInfo = notification.userInfo,
                  let vc = userInfo["vc"] as? VCs else { return }
            
            switch vc {
            case .registration:
                self.window?.rootViewController = Builder.createRegistrationView()
            case .authorization:
                self.window?.rootViewController = Builder.createAuthorizationView()
            case .main:
                self.window?.rootViewController = Builder.createMainView()
            }
        }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .changeRootViewController, object: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
