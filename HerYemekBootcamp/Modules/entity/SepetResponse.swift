//
//  SepetResponse.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation


struct SepetResponse: Codable {
    var sepet_yemekler: Array<Sepet>?
    var success: Int?
}


