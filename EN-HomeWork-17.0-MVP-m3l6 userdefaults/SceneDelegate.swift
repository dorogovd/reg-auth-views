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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        let isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
        let initialViewController: UIViewController
        
        if isRegistered {
            if isLogin {
                initialViewController = Builder.createMainView()
            } else {
                initialViewController = Builder.createAuthorizationView()
            }
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
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
