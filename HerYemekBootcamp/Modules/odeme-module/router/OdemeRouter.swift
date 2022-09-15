//
//  OdemeRouter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 6.09.2022.
//

import Foundation

class OdemeRouter: PresenterToRouterOdemeProtocol {
    static func createModule(ref: OdemeViewController) {
        let presenter = OdemePresenter()
        
        ref.OdemePresenterNesnesi = presenter
        ref.OdemePresenterNesnesi?.OdemeInteractor = OdemeInteractor()

    }
    
    
}
