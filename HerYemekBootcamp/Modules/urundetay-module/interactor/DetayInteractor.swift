//
//  DetayInteractor.swift
//  HerYemekBootcamp
//
//  Created by Mac on 3.09.2022.
//

import Foundation
import Alamofire

class DetayInteractor: PresenterToInteractorDetayProtocol {

    var DetayPresenter: InteractorToPresenterDetayProtocol?
    
    func sepeteUrunEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        
        let parameters:Parameters =  ["yemek_adi": yemek_adi,
                                      "yemek_resim_adi":yemek_resim_adi,
                                 "yemek_fiyat":yemek_fiyat,
                                 "yemek_siparis_adet":yemek_siparis_adet,
                                 "kullanici_adi":kullanici_adi]
        let url = URL(string: URLConstants.sendeToCart)
        AF.request(url!,method: .post,parameters: parameters).response{ response in
            
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                    }
                }catch{
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
                    self.DetayPresenter?.presenteraVeriGonder(sepet: sepetList.reversed())
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepettenUrunSil(sepet_yemek_id: String, kullanici_adi: String) {
        let parameters : Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        
        let url = URL(string: URLConstants.deleteCartFood)
        
        AF.request(url!, method: .post, parameters: parameters).response { response in
            if let data = response.data {
                do {
                    let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                    print(json)
                    self.sepetiTumGetir(kullanici_adi: kullanici_adi)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
  
}
