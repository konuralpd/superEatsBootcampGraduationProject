//
//  MenuProtocols.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation

protocol ViewToPresenterMenuProtocol {
    
    var MenuInteractor: PresenterToInteractorMenuProtocol? { get set }
    var MenuView: PresenterToViewMenuProtocol? { get set }
    func sepetToplamFiyat(kullanici_adi: String)
    func sepetietir(kullanici_adi: String)
    func getFoodsFromDB()

}

protocol PresenterToInteractorMenuProtocol {
    
    var MenuPresenter: InteractorToPresenterMenuProtocol? { get set }
    func sepettekilerinToplamFiyatiniGetir(kullanici_adi: String)
    func sepetiTumGetir(kullanici_adi: String)
    func getFoods()
}

protocol InteractorToPresenterMenuProtocol {
    func presenteraVeriGonder(adet: Int)
    func presenteraSepetAdetVeriGonder(sepet: Array<Sepet>)
    func presenteraVeriGonder(Yemekler: Array<Yemek>)
}

protocol PresenterToViewMenuProtocol {
    func viwewaVeriGonder(adet: Int)
    func viewaVeriGonder(Yemekler: Array<Yemek>)
    func vieweSepetAdetVeriGonder(sepet: Array<Sepet>)
}

protocol PresenterToRouterMenuProtocol {
    static func createModule(ref: MenuVC)
}
