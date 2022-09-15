//
//  DetayProtocols.swift
//  HerYemekBootcamp
//
//  Created by Mac on 3.09.2022.
//

import Foundation


protocol ViewToPresenterDetayProtocol {
    var DetayInteractor: PresenterToInteractorDetayProtocol? { get set }
    var DetayView: PresenterToViewDetayProtcol? { get set }
    func sepeteEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int,kullanici_adi:String)
    func sepetiGetir(kullanici_adi: String)
    func sepettenUrunSil(sepet_yemek_id:String, kullanici_adi: String)
}

protocol PresenterToInteractorDetayProtocol {
    var DetayPresenter: InteractorToPresenterDetayProtocol? { get set }
    func sepeteUrunEkle(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int,kullanici_adi:String)
    func sepetiTumGetir(kullanici_adi: String)
    func sepettenUrunSil(sepet_yemek_id:String, kullanici_adi: String)
}

protocol InteractorToPresenterDetayProtocol {
    func navigateLastVC()
    func presenteraVeriGonder(sepet: Array<Sepet>)

}

protocol PresenterToViewDetayProtcol {
    func navigateLastVC()
    func vieweVeriGonder(sepet: Array<Sepet>)

}

protocol PresenterToRouterDetayProtocol {
    static func createModule(ref: UrunDetayViewController)
}

