//
//  SepetRouter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 4.09.2022.
//

import Foundation

class SepetRouter: PresenterToRouterSepetProtocol {
    static func createModule(ref: SepetViewController) {
        let presenter = SepetPresenter()
        
        ref.sepetPresenterNesnesi = presenter
        ref.sepetPresenterNesnesi?.SepetInteractor = SepetInteractor()
        ref.sepetPresenterNesnesi?.SepetView = ref
        ref.sepetPresenterNesnesi?.SepetInteractor?.SepetPresenter = presenter
    }
    
    
}
