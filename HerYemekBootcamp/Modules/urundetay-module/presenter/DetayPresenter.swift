//
//  DetayPresenter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 3.09.2022.
//

import Foundation

class DetayPresenter: ViewToPresenterDetayProtocol {

    var DetayInteractor: PresenterToInteractorDetayProtocol?
    
    var DetayView: PresenterToViewDetayProtcol?
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        DetayInteractor?.sepeteUrunEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    func sepetiGetir(kullanici_adi: String) {
        DetayInteractor?.sepetiTumGetir(kullanici_adi: kullanici_adi)
    }
    
    func sepettenUrunSil(sepet_yemek_id: String, kullanici_adi: String) {
        DetayInteractor?.sepettenUrunSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    

}

extension DetayPresenter: InteractorToPresenterDetayProtocol {
    func navigateLastVC() {
        DetayView?.navigateLastVC()
    }
    
    func presenteraVeriGonder(sepet: Array<Sepet>) {
        DetayView?.vieweVeriGonder(sepet: sepet)
    }
    
    
}
