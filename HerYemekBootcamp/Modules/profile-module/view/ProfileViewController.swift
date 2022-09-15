//
//  ProfileViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 15.09.2022.
//

import UIKit
import FirebaseAuth


var window: UIWindow?

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profilim"
        navigationItem.hidesBackButton = false
        
    }
    
    @IBAction func signOutButtonClicked(_ sender: Any) { //Firebase üyelik çıkışı işlemi.
        let firebaseAuth = Auth.auth()
        
        let alertController = UIAlertController(title: "Çıkış", message: "Çıkış yapmak istediğinize emin misiniz?", preferredStyle: .alert)

          // Create the actions
        let okAction = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) {
              UIAlertAction in
            do {
              try firebaseAuth.signOut()
                self.performSegue(withIdentifier: "signOutToLogin", sender: nil)

            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
              NSLog("OK Pressed")
          }
        let cancelAction = UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel) {
              UIAlertAction in
              NSLog("Cancel Pressed")
          }

          // Add the actions
          alertController.addAction(okAction)
          alertController.addAction(cancelAction)

          // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}
