//
//  HomeInteractor.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation
import Alamofire

class HomeInteractor: PresenterToInteractorHomeProtocol {
 
    var HomePresenter: InteractorToPresenterHomeProtocol?
    
    func sepetTutariniAl(kullanici_adi: String) {
        let params: Parameters = ["kullanici_adi": kullanici_adi]
        let url = URL(string: URLConstants.getCartFoods)
        AF.request(url!, method: .post, parameters: params).response { [weak self] response in
            if let data = response.data {
                do {
                    let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                    if json.success == 1 {
                        var sepetTutar = 0
                        
                        if let sepet = json.sepet_yemekler {
                            for urun in sepet {
                                let fiyat = Int(urun.yemek_fiyat!)!
                                let adet = Int(urun.yemek_siparis_adet!)!
                                sepetTutar = fiyat * adet
                            }
                        }
                        
                        self?.HomePresenter?.presenteraVeriGonder(tutar: sepetTutar)
                    }
                } catch {
                    self?.HomePresenter?.presenteraVeriGonder(tutar: 0)
                    print(error.localizedDescription)
                }
            }
        }
    }
    func sepetiTumGetir(kullanici_adi: String) {
        let parameters : Parameters = ["kullanici_adi": kullanici_adi]
        
        let url = URL(string: URLConstants.getCartFoods)
        
        AF.request(url!, method: .post, parameters: parameters).response { response in
            if let data = response.data {
                do {
                    let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                   var sepetList = [Sepet]()
                    if let gelenList = json.sepet_yemekler {
                        sepetList = gelenList
                    }
                    self.HomePresenter?.presenteraSepetAdetVeriGonder(sepet: sepetList)
                } catch {
                    self.HomePresenter?.presenteraSepetAdetVeriGonder(sepet: [Sepet]())
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
