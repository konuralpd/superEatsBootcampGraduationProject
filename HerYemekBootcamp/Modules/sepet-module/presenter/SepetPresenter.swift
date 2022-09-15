//
//  SepetPresenter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 4.09.2022.
//

import Foundation

class SepetPresenter: ViewToPresenterSepetProtocol {

    var SepetInteractor: PresenterToInteractorSepetProtocol?
    
    var SepetView: PresenterToViewSepetProtocol?
    
    func sepetiGetir(kullanici_adi: String) {
        SepetInteractor?.sepetiTumGetir(kullanici_adi: kullanici_adi)
    }
    
    func urunSil(sepet_yemek_id: String, kullanici_adi: String) {
        SepetInteractor?.sepettenUrunSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func adetiDegistir(adet: Int, nesne: Sepet) {
        SepetInteractor?.urunAdetDegistir(adet: adet, nesne: nesne)
    }
    
    func sepetSil(list: [Sepet]) {
        SepetInteractor?.sepetiTumSil(list: list)
    }
    
    
}

extension SepetPresenter: InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(sepet: Array<Sepet>) {
        SepetView?.vieweVeriGonder(sepet: sepet)
    }
    
    
}
