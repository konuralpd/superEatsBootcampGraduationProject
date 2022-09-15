//
//  LoginPresenter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation


class LoginPresenter: ViewToPresenterLoginProtocol {
    var loginInteractor: PresenterToInteractorLoginProtocol?
    
    var loginView: PresenterToViewLoginProtocol?
    
  
    func giris(email: String, password: String) {
        loginInteractor?.girisYap(email: email, password: password)
    }
    
}

extension LoginPresenter: InteractorToPresenterLoginProtocol {
    func presenteraErroGonder(error: Error?) {
        loginView?.viewaErrorGonder(error: error)
    }
    
}
