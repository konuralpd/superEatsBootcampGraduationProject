//
//  LoginProtocols.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation

protocol ViewToPresenterLoginProtocol {
    var loginInteractor: PresenterToInteractorLoginProtocol? { get set }
    var loginView: PresenterToViewLoginProtocol? { get set }
    func giris(email: String, password:String)
}


protocol PresenterToInteractorLoginProtocol {
    var loginPresenter: InteractorToPresenterLoginProtocol? { get set }
    func girisYap(email: String, password:String)
}

protocol InteractorToPresenterLoginProtocol {
    func presenteraErroGonder(error: Error?)
}

protocol PresenterToViewLoginProtocol {
    func viewaErrorGonder(error: Error?)
}

protocol PresenterToRouterLoginProtocol {
    static func createModule(ref: LoginViewController)
}
