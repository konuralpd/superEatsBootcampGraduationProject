//
//  SepetViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import UIKit
import Kingfisher
import ProgressHUD
import FirebaseAuth

class UrunDetayViewController: UIViewController {

    var gelenData: Yemek?
    var gelenKullaniciAdi: String?
    var sepetList = [Sepet]()
    @IBOutlet weak var urunAdilabel: UILabel!
    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var toplamFiyatButton: UIButton!
    
    @IBOutlet weak var urunImageView: UIImageView!
    var DetayPresenterNesnesi: ViewToPresenterDetayProtocol?
    var kullaniciAdi = Auth.auth().currentUser?.email!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUrun()
        DetayRouter.createModule(ref: self)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DetayPresenterNesnesi?.sepetiGetir(kullanici_adi: kullaniciAdi!)
    }
        
    
    func setUrun() {
        guard let gelenData = gelenData else { return }
        if let imgUrl = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(gelenData.yemek_resim_adi!)" ) {
            urunImageView.kf.setImage(with: imgUrl)
            toplamFiyatButton.setTitle("\(gelenData.yemek_fiyat ?? "")₺", for: .normal)
            urunAdilabel.text = gelenData.yemek_adi
            adetLabel.text = "1"
            self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        }
    }
    
    @IBAction func azaltButton(_ sender: UIButton) {
        if Int(adetLabel.text!)! > 1 {
            let yeniAdet = Int(adetLabel.text!)! - 1
            adetLabel.text = "\(yeniAdet)"
            let fiyat = Int((gelenData?.yemek_fiyat)!)!
            let toplamFiyat = fiyat * yeniAdet
            adetLabel.alpha = 0
            toplamFiyatButton.setTitle("\(toplamFiyat)₺", for: .normal)
            UIView.animate(withDuration: 1){ [self] in
            adetLabel.alpha = 1.0
            }
    }
    }
    
    @IBAction func ekleButton(_ sender: UIButton) {
    
        let yeniAdet = Int(adetLabel.text!)! + 1
        adetLabel.text = "\(yeniAdet)"
        let fiyat = Int((gelenData?.yemek_fiyat)!)!
        let toplamFiyat = fiyat * yeniAdet
        adetLabel.alpha = 0
        toplamFiyatButton.setTitle("\(toplamFiyat)₺", for: .normal)
        UIView.animate(withDuration: 1){ [self] in
        adetLabel.alpha = 1.0
        }
        
    }
    
    @IBAction func sepeteEkleClicked(_ sender: UIButton) {
        
        var ayniUrun = false
        for yemek in sepetList {
            if (gelenData?.yemek_adi == yemek.yemek_adi) {
                DetayPresenterNesnesi?.sepettenUrunSil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: kullaniciAdi!)
                let toplamUrunAdeti = Int(adetLabel.text!)! + Int(yemek.yemek_siparis_adet!)!
                if let yad = gelenData?.yemek_adi, let yemek = gelenData {
                    DetayPresenterNesnesi?.sepeteEkle(yemek_adi: yad, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: toplamUrunAdeti, kullanici_adi: kullaniciAdi!)
                }
                ayniUrun = true
            }
        }
        
        if ayniUrun == false {
            if let yad = gelenData?.yemek_adi, let yadet = adetLabel.text, let yemek = gelenData {
                DetayPresenterNesnesi?.sepeteEkle(yemek_adi: yad, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: Int(yadet)!, kullanici_adi: kullaniciAdi!)
            }
        }
        

        DetayPresenterNesnesi?.sepetiGetir(kullanici_adi: kullaniciAdi!)
        ProgressHUD.show(icon: .cart)
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.colorHUD = UIColor.systemCyan
        ProgressHUD.colorBackground = .white
        navigateLastVC()
        
    }
    
}

extension UrunDetayViewController: PresenterToViewDetayProtcol {
    func vieweVeriGonder(sepet: Array<Sepet>) {
        self.sepetList = sepet
        print(sepetList.count)
    }
    
    func navigateLastVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


