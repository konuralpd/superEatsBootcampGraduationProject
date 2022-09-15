//
//  LoginInteractor.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation
import Alamofire
import FirebaseAuth

class LoginInteractor: PresenterToInteractorLoginProtocol {
   
    var loginPresenter: InteractorToPresenterLoginProtocol?

    func girisYap(email: String, password: String) {
        let auth = FirebaseAuth.Auth.auth()
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            
            if let error = error {

                self?.loginPresenter?.presenteraErroGonder(error: error)
                print(error.localizedDescription)
                
            } else {
                self?.loginPresenter?.presenteraErroGonder(error: nil)
                
                
            }
            
    }
}
}
