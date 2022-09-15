//
//  YemekResponse.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import Foundation

struct YemekResponse: Codable {
    var yemekler: Array<Yemek>?
    var success: Int?
}
