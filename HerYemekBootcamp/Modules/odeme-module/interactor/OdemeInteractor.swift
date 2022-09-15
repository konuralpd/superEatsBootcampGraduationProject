//
//  OdemeInteractor.swift
//  HerYemekBootcamp
//
//  Created by Mac on 6.09.2022.
//

import Foundation
import Alamofire

class OdemeInteractor: PresenterToInteractorOdemeProtocol {
    func odemeOnaylandiSepetiBosalt(sepet: Array<Sepet>) {
        for urun in sepet {
            let parameters:Parameters = ["sepet_yemek_id":Int(urun.sepet_yemek_id!)!,"kullanici_adi":urun.kullanici_adi!]
            let url = URL(string: URLConstants.deleteCartFood)
            AF.request(url!,method: .post,parameters: parameters).response { response in
                
                if let data = response.data {
                    do{
                        let json = try JSONDecoder().decode(SepetResponse.self, from: data)
                        if json.success == 1 {
                              print("Odeme onaylandi sepet bosaltildi.")
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
