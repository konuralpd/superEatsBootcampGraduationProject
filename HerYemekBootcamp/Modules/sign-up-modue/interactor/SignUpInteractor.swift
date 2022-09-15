//
//  SignUpInteractor.swift
//  HerYemekBootcamp
//
//  Created by Mac on 15.09.2022.
//

import Foundation
import FirebaseAuth
import UIKit
import ProgressHUD

class SignUpInteractor: PresenterInteractorSignUpProtocol {
    var signupPresenter: InteractorPresenterSignUpProtocol?
     
    func kayitOl(email: String, password: String) {
       let auth = Auth.auth()
        
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {

                self.signupPresenter?.presenteraErroGonder(error: error)
                print(error.localizedDescription)
                
            } else {
                self.signupPresenter?.presenteraErroGonder(error: nil)
        }
    }
}
}

