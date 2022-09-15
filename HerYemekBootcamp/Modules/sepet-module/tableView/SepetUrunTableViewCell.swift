//
//  SepetUrunTableViewCell.swift
//  HerYemekBootcamp
//
//  Created by Mac on 4.09.2022.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class SepetUrunTableViewCell: UITableViewCell {
    @IBOutlet weak var urunImageView: UIImageView!
    @IBOutlet weak var urunLabel: UILabel!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    
    var urun: Sepet?
    var sepetPresenterNesnesi : ViewToPresenterSepetProtocol?
    var kullaniciAdi = Auth.auth().currentUser?.email!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    func tableViewCellFadeEffect(_ tableView:UITableViewCell){
        tableView.alpha = 0
        UIView.animate(withDuration: 1){
        tableView.alpha = 1.0
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func minusButtonClicked(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if Int((self.urun?.yemek_siparis_adet!)!)! > 1 {
                let yeniAdet = Int(self.adetLabel.text!)! - 1
                self.adetLabel.text = "\(yeniAdet)"
                self.sepetPresenterNesnesi?.adetiDegistir(adet: yeniAdet, nesne: self.urun!)
                self.minusButton.isUserInteractionEnabled = false
            } else {
                self.sepetPresenterNesnesi?.urunSil(sepet_yemek_id: (self.urun?.sepet_yemek_id!)!, kullanici_adi: kullaniciAdi!)
            }
            self.minusButton.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if Int((self.urun?.yemek_siparis_adet!)!)! >= 0 {
            let yeniAdet = Int(self.adetLabel.text!)! + 1
            self.adetLabel.text = "\(yeniAdet)"
            self.sepetPresenterNesnesi?.adetiDegistir(adet: yeniAdet, nesne: self.urun!)
            self.plusButton.isUserInteractionEnabled = false
            
        }
        self.plusButton.isUserInteractionEnabled = true
    }
    }
  
    
    @IBAction func silButtonClick(_ sender: Any) {
        self.sepetPresenterNesnesi?.urunSil(sepet_yemek_id: (urun?.sepet_yemek_id!)!, kullanici_adi: kullaniciAdi!)
        self.sepetPresenterNesnesi?.sepetiGetir(kullanici_adi: kullaniciAdi!)
        ProgressHUD.show(icon: .failed)
        tableViewCellFadeEffect(self)
 
    }
}
