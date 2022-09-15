//
//  SepetInteractor.swift
//  HerYemekBootcamp
//
//  Created by Mac on 4.09.2022.
//

import Foundation
import Alamofire
import FirebaseAuth

class SepetInteractor: PresenterToInteractorSepetProtocol {
   
    var kullaniciAdi = Auth.auth().currentUser?.email!
    var SepetPresenter: InteractorToPresenterSepetProtocol?
    
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
                        self.SepetPresenter?.presenteraVeriGonder(sepet: sepetList)
                    }
                } catch {
                    self.SepetPresenter?.presenteraVeriGonder(sepet: [Sepet]())
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
    func urunAdetDegistir(adet: Int, nesne: Sepet) {
        let parameterss:Parameters = ["sepet_yemek_id":Int(nesne.sepet_yemek_id!)!,"kullanici_adi":nesne.kullanici_adi!]
        let url = URL(string: URLConstants.deleteCartFood)
        AF.request(url!,method: .post,parameters: parameterss).response { response in
            
            if let data = response.data {
                do{
                    let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                    if json.success == 1 {
                        self.urunEkle(nesne: nesne, adet: adet)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    func urunEkle(nesne:Sepet,adet:Int){
        let params:Parameters = ["yemek_adi":nesne.yemek_adi!,"yemek_resim_adi":nesne.yemek_resim_adi!,"yemek_fiyat":Int(nesne.yemek_fiyat!)!,"yemek_siparis_adet":adet,"kullanici_adi":nesne.kullanici_adi!]
        let url = URL(string: URLConstants.sendeToCart)
        AF.request(url!,method: .post,parameters: params).response { [weak self] response in
            
            if let data = response.data {
                do{
                    let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                    if json.success == 1 {
                        self?.sepetiTumGetir(kullanici_adi: nesne.kullanici_adi!)
                        
                    }
                }catch{
                    
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepetiTumSil(list: [Sepet]) {
        for yemek in list {
            sepettenUrunSil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: kullaniciAdi!)
            
        }
    }
}
