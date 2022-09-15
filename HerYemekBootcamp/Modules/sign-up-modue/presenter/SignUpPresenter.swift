//
//  SignUpPresenter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 15.09.2022.
//

import Foundation


class SignUpPresenter: ViewToPresenterSignUpProtocol {
    var signUpView: PresenterToViewSignUpProtocol?
    
    var signUpInteractor: PresenterInteractorSignUpProtocol?
    
    func kayit(email: String, password: String) {
        signUpInteractor?.kayitOl(email: email, password: password)
    }
    
    
}

extension SignUpPresenter: InteractorPresenterSignUpProtocol {
    func presenteraErroGonder(error: Error?) {
        signUpView?.viewaErrorGonder(error: error)
    }
    
    
}
