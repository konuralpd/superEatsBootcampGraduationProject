//
//  SignUpRouter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 15.09.2022.
//

import Foundation

class SignUpRouter: PresenterToRouterSignUpProtocol {
    static func createModule(ref: SignUpViewController) {
        let presenter = SignUpPresenter()
        
        ref.signUpPresenterNesnesi = presenter
        ref.signUpPresenterNesnesi?.signUpInteractor = SignUpInteractor()
        ref.signUpPresenterNesnesi?.signUpView = ref
        ref.signUpPresenterNesnesi?.signUpInteractor?.signupPresenter = presenter
    }

}
