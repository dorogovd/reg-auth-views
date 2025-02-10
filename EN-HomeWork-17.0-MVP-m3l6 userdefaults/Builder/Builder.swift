//
//  Builder.swift
//  EN-HomeWork-17.0-MVP-m3l6 userdefaults
//
//  Created by Dmitrii Dorogov on 07.12.2024.
//

import UIKit

class Builder {
    
    static func createRegistrationView() -> UIViewController {
        let view = RegistrationView()
        let presenter = RegistrationViewPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
    
    static func createAuthorizationView() -> UIViewController {
        let view = AuthorizationView()
        let presenter = AuthorizationViewPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
    
    static func createMainView() -> UIViewController {
        let view = MainView()
        let presenter = MainViewPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
}
