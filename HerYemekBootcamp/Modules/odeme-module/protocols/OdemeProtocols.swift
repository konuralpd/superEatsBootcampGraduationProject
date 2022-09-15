//
//  OdemeProtocols.swift
//  HerYemekBootcamp
//
//  Created by Mac on 6.09.2022.
//

import Foundation


protocol ViewToPresenterOdemeProtocol {
    var OdemeInteractor:PresenterToInteractorOdemeProtocol? {get set}
    func sepetiBosalt(sepet: Array<Sepet>)
    
}

protocol PresenterToInteractorOdemeProtocol {
    func odemeOnaylandiSepetiBosalt(sepet: Array<Sepet>)
}

protocol PresenterToRouterOdemeProtocol {
    static func createModule(ref: OdemeViewController)
}
