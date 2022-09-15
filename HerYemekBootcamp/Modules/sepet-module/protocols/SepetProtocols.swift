//
//  SepetProtocols.swift
//  HerYemekBootcamp
//
//  Created by Mac on 4.09.2022.
//

import Foundation

protocol ViewToPresenterSepetProtocol {
    var SepetInteractor: PresenterToInteractorSepetProtocol? { get set }
    var SepetView: PresenterToViewSepetProtocol? { get set }
    
    func sepetiGetir(kullanici_adi: String)
    func urunSil(sepet_yemek_id:String, kullanici_adi: String)
    func adetiDegistir(adet:Int,nesne:Sepet)
    func sepetSil(list: [Sepet])
}

protocol PresenterToInteractorSepetProtocol {
    var SepetPresenter: InteractorToPresenterSepetProtocol? { get set }
    
    func sepetiTumGetir(kullanici_adi: String)
    func sepettenUrunSil(sepet_yemek_id:String, kullanici_adi: String)
    func urunAdetDegistir(adet:Int,nesne:Sepet)
    func sepetiTumSil(list: [Sepet])
}

protocol InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(sepet: Array<Sepet>)
}

protocol PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepet: Array<Sepet>)
}

protocol PresenterToRouterSepetProtocol {
    static func createModule(ref: SepetViewController)
}

