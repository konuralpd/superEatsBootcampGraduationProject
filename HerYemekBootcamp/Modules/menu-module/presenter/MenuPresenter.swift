//
//  MenuPresenter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation


class MenuPresenter: ViewToPresenterMenuProtocol {
    func getFoodsFromDB() {
        MenuInteractor?.getFoods()
    }
    
   
    var MenuInteractor: PresenterToInteractorMenuProtocol?
    
    var MenuView: PresenterToViewMenuProtocol?
    
    func sepetToplamFiyat(kullanici_adi: String) {
        MenuInteractor?.sepettekilerinToplamFiyatiniGetir(kullanici_adi: kullanici_adi)
    }
    func sepetietir(kullanici_adi: String) {
        MenuInteractor?.sepetiTumGetir(kullanici_adi: kullanici_adi)
    }

    
    
}
extension MenuPresenter: InteractorToPresenterMenuProtocol {
    func presenteraVeriGonder(Yemekler: Array<Yemek>) {
        MenuView?.viewaVeriGonder(Yemekler: Yemekler)
    }
    
    func presenteraSepetAdetVeriGonder(sepet: Array<Sepet>) {
        MenuView?.vieweSepetAdetVeriGonder(sepet: sepet)
    }
    
    func presenteraVeriGonder(adet: Int) {
        MenuView?.viwewaVeriGonder(adet: adet)
    }
    
  
    
    
}
