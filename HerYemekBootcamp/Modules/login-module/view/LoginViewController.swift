//
//  GirisViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var kullaniciAdiTF: UITextField!
    @IBOutlet weak var sifreTF: UITextField!
    
    var loginPresenterNesnesi: ViewToPresenterLoginProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LoginRouter.createModule(ref: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnasayfaVC" {
            let navController = segue.destination as! UINavigationController
            let destVC = navController.topViewController as! HomePageViewController
          destVC.gelenKullaniciAdi = kullaniciAdiTF.text
            
        
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        guard let email = kullaniciAdiTF.text else { return }
        guard let sifre = sifreTF.text else { return }
        
        loginPresenterNesnesi?.giris(email: email, password: sifre)
        
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
}


extension LoginViewController: PresenterToViewLoginProtocol {
    func viewaErrorGonder(error: Error?) {
        if let error = error {
            ProgressHUD.showError("Giriş Başarısız.")
            ProgressHUD.colorHUD = UIColor.white
            ProgressHUD.animationType = .singleCircleScaleRipple
            ProgressHUD.colorBackground = UIColor.red
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                ProgressHUD.dismiss()
                print(error.localizedDescription)
            }
        } else {
            ProgressHUD.showSuccess("Başarıyla giriş yapıldı.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self!.performSegue(withIdentifier: "toAnasayfaVC", sender: nil)
            }
        }
    }
    
}
