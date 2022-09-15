//
//  MenuRouter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation

class MenuRouter: PresenterToRouterMenuProtocol {
    static func createModule(ref: MenuVC) {
        let presenter = MenuPresenter()
        
        ref.MenuPresenterNesnesi = presenter
        ref.MenuPresenterNesnesi?.MenuInteractor = MenuInteractor()
        ref.MenuPresenterNesnesi?.MenuView = ref
        
        ref.MenuPresenterNesnesi?.MenuInteractor?.MenuPresenter = presenter
    }
    
    
}
