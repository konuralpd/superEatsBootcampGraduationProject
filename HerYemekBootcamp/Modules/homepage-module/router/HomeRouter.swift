//
//  HomeRouter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation

class HomeRouter: PresenterToRouterHomeProtocol {
    static func createModule(ref: HomePageViewController) {
        let presenter = HomePresenter()
        
        ref.homePresenterNesnesi = presenter
        ref.homePresenterNesnesi?.HomeInteractor = HomeInteractor()
        ref.homePresenterNesnesi?.HomeView = ref
        ref.homePresenterNesnesi?.HomeInteractor?.HomePresenter = presenter
    }
    
    
}
