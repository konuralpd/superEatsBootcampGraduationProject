//
//  LoginRouter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation


class LoginRouter: PresenterToRouterLoginProtocol {
    static func createModule(ref: LoginViewController) {
        let presenter = LoginPresenter()
        
        ref.loginPresenterNesnesi = presenter
        
        ref.loginPresenterNesnesi?.loginInteractor = LoginInteractor()
        ref.loginPresenterNesnesi?.loginView = ref
        
        ref.loginPresenterNesnesi?.loginInteractor?.loginPresenter = presenter
        
    }
    
    
}
