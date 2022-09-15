//
//  UIViewController+Extensions.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import UIKit

extension UIViewController {
    func setupClearNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupGradient(height: CGFloat, topColor: CGColor, bottomColor: CGColor) ->  CAGradientLayer {
             let gradient: CAGradientLayer = CAGradientLayer()
             gradient.colors = [topColor,bottomColor]
             gradient.locations = [0.0 , 1.0]
             gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
             gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
             gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: height)
             return gradient
        }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
