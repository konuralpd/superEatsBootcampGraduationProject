//
//  OdemePresenter.swift
//  HerYemekBootcamp
//
//  Created by Mac on 6.09.2022.
//

import Foundation

class OdemePresenter: ViewToPresenterOdemeProtocol {
    var OdemeInteractor: PresenterToInteractorOdemeProtocol?
    
    func sepetiBosalt(sepet: Array<Sepet>) {
        OdemeInteractor?.odemeOnaylandiSepetiBosalt(sepet: sepet)
    }
        
}
