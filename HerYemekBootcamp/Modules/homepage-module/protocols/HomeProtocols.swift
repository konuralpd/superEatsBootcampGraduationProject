//
//  HomeProtocols.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation


protocol ViewToPresenterHomeProtocol {
    var HomeInteractor: PresenterToInteractorHomeProtocol? { get set }
    var HomeView: PresenterToViewHomeProtocol? { get set }
    func sepetTutari(kullanici_adi: String)
    func sepetiGetir(kullanici_adi: String)
}

protocol PresenterToInteractorHomeProtocol {
    var HomePresenter: InteractorToPresenterHomeProtocol? { get set }
    func sepetTutariniAl(kullanici_adi: String)
    func sepetiTumGetir(kullanici_adi: String)
}

protocol InteractorToPresenterHomeProtocol {
    func presenteraVeriGonder(tutar: Int)
    func presenteraSepetAdetVeriGonder(sepet: Array<Sepet>)
}

protocol PresenterToViewHomeProtocol {
    func viewaVeriGonder(tutar: Int)
    func vieweSepetAdetVeriGonder(sepet: Array<Sepet>)
    
}

protocol PresenterToRouterHomeProtocol {
    static func createModule(ref: HomePageViewController)
}
