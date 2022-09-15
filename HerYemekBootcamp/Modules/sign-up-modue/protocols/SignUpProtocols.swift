//
//  SignUpProtocols.swift
//  HerYemekBootcamp
//
//  Created by Mac on 15.09.2022.
//

import Foundation

protocol ViewToPresenterSignUpProtocol {
    var signUpInteractor: PresenterInteractorSignUpProtocol? { get set }
    var signUpView: PresenterToViewSignUpProtocol? { get set }
    func kayit(email: String, password:String)
    
}

protocol PresenterInteractorSignUpProtocol {
    var signupPresenter: InteractorPresenterSignUpProtocol? { get set }
    
    func kayitOl(email: String, password:String)
}
 

protocol InteractorPresenterSignUpProtocol {
    func presenteraErroGonder(error: Error?)
}

protocol PresenterToViewSignUpProtocol {
    func viewaErrorGonder(error: Error?)
}

protocol PresenterToRouterSignUpProtocol {
    static func createModule(ref: SignUpViewController)
}
