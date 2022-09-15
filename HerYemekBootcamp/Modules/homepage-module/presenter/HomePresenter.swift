//
//  HomePresenter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation


class HomePresenter: ViewToPresenterHomeProtocol {

    var HomeInteractor: PresenterToInteractorHomeProtocol?
    
    var HomeView: PresenterToViewHomeProtocol?
    
    func sepetTutari(kullanici_adi: String) {
        HomeInteractor?.sepetTutariniAl(kullanici_adi: kullanici_adi)
    }
    func sepetiGetir(kullanici_adi: String) {
        HomeInteractor?.sepetiTumGetir(kullanici_adi: kullanici_adi)
    }
    

    
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func presenteraSepetAdetVeriGonder(sepet: Array<Sepet>) {
        HomeView?.vieweSepetAdetVeriGonder(sepet: sepet)
    }
    
  
    
    func presenteraVeriGonder(tutar: Int) {
        HomeView?.viewaVeriGonder(tutar: tutar)
    }
    
    
}
