//
//  MenuInteractor.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation
import Alamofire
import FirebaseAuth

class MenuInteractor: PresenterToInteractorMenuProtocol {

    
    var MenuPresenter: InteractorToPresenterMenuProtocol?
    var kullaniciAdi = Auth.auth().currentUser?.email!
    
    
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
                    self.MenuPresenter?.presenteraSepetAdetVeriGonder(sepet: sepetList)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepettekilerinToplamFiyatiniGetir(kullanici_adi: String) {
        let parameters: Parameters = ["kullanici_adi": kullanici_adi]
        let url = URL(string: URLConstants.getCartFoods)
        AF.request(url!,method: .post,parameters: parameters).response {  response in
            if let data = response.data {
                do {
                    let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                    
                    if json.success == 1 {
                        var toplam = 0
                        
                        if let sepet = json.sepet_yemekler {
                            for yemek in sepet {
                                let fiyat = Int(yemek.yemek_fiyat!)!
                                let adet = Int(yemek.yemek_siparis_adet!)!
                                toplam = toplam + (fiyat * adet)
                            }
                        }
                        
                        self.MenuPresenter?.presenteraVeriGonder(adet: toplam)
                    }
                } catch {
                    self.MenuPresenter?.presenteraSepetAdetVeriGonder(sepet: [Sepet]())
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getFoods() {
        let url = URL(string: URLConstants.getAllFoods)
        
        AF.request(url!, method: .get).response { [weak self] response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(YemekResponse.self, from: data)
                    
                    var yemekList = [Yemek]()
                    if let gelenList = cevap.yemekler {
                        yemekList = gelenList
                    }
                    
                    self?.MenuPresenter?.presenteraVeriGonder(Yemekler: yemekList)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
}
