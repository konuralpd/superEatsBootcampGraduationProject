//
//  DetayRouter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 3.09.2022.
//

import Foundation

class DetayRouter: PresenterToRouterDetayProtocol {
    static func createModule(ref: UrunDetayViewController) {
        let presenter = DetayPresenter()
        ref.DetayPresenterNesnesi = presenter
        ref.DetayPresenterNesnesi?.DetayInteractor = DetayInteractor()
        ref.DetayPresenterNesnesi?.DetayView = ref
        ref.DetayPresenterNesnesi?.DetayInteractor?.DetayPresenter = presenter
    }
    
    
}
