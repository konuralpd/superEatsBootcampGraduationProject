//
//  SignUpViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 15.09.2022.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var sifreTF: UITextField!
    
    var signUpPresenterNesnesi: ViewToPresenterSignUpProtocol?
    var kullaniciKayitOlmus = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignUpRouter.createModule(ref: self)

    }
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        guard let email = emailTF.text else { return }
        guard let sifre = sifreTF.text else { return }
   
        signUpPresenterNesnesi?.kayit(email: email, password: sifre)
    
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    

}

extension SignUpViewController: PresenterToViewSignUpProtocol {
    func viewaErrorGonder(error: Error?) {
  
        if let error = error {
            ProgressHUD.showError("Kayıt olunamadı lütfen bilgilerinizi kontrol ederek tekrardan üyelik oluşturmayı deneyin.")
            print(error.localizedDescription)
        } else {
            ProgressHUD.showSuccess("Başarıyla kayıt olundu.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self!.performSegue(withIdentifier: "toLogin", sender: nil)
            }
        }
    }
    
    
}

