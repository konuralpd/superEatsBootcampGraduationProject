//
//  SepetViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 3.09.2022.
//

import UIKit
import Alamofire
import ProgressHUD
import Kingfisher
import FirebaseAuth


class SepetViewController: UIViewController {

    @IBOutlet weak var sepetToplamLabel: UILabel!
    @IBOutlet weak var sepetTableView: UITableView!
    @IBOutlet weak var sepetTutariLabel: UILabel!
    @IBOutlet weak var indirimliFiyatLabel: UILabel!
    @IBOutlet weak var sepetYaziStack: UIStackView!
    @IBOutlet weak var promosyonKodu: UIImageView!
    @IBOutlet weak var sepetSayiStack: UIStackView!
    @IBOutlet weak var odemeyeGecButton: UIButton!
    
    
    var sepetPresenterNesnesi : ViewToPresenterSepetProtocol?
    var sepetList = [Sepet]()
    var urun: Yemek?
    var toplamFiyat: Int = 0
    var fiyat: Int = 0
    var kullaniciAdi = Auth.auth().currentUser?.email!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        SepetRouter.createModule(ref: self)
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sepetPresenterNesnesi?.sepetiGetir(kullanici_adi: kullaniciAdi!)
        self.sepetTableView.reloadData()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOdeme" {
            let destinationVC = segue.destination as! OdemeViewController
            destinationVC.sepetList = sepetList
        }
    }

    
    
    @IBAction func odemeyeGecButtonClicked(_ sender: Any) {
        if sepetList.count == 0  {
            ProgressHUD.showError("Sepetinizde hiç ürün yok, lütfen sepetinize ürün ekleyin.")
        } else if toplamFiyat < 50 {
            ProgressHUD.showError("Minimum sepet tutarının altındasınız, lütfen ürün ekleyin.")
        } else {
            performSegue(withIdentifier: "toOdeme", sender: nil)
            }
    }
    
    @IBAction func sepetiSilButton(_ sender: Any) {
        sepetPresenterNesnesi?.sepetSil(list: sepetList)
        navigationController?.popViewController(animated: true)
    }
    
}

extension SepetViewController: PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepet: Array<Sepet>) {
        DispatchQueue.main.async { [self] in
        self.sepetList = sepet
            self.sepetTableView.reloadData()
            if sepet.count == 0 {
                sepetYaziStack.isHidden = true
                sepetSayiStack.isHidden = true
                promosyonKodu.isHidden = true
                odemeyeGecButton.isHidden = true
                self.navigationController?.popViewController(animated: true)
            }
            

            toplamFiyat = 0
                   for i in sepet {
                       toplamFiyat += Int(i.yemek_fiyat!)! * Int(i.yemek_siparis_adet!)!
                   }
        let indirimOrani = Double(20)
        let indirimliFiyat = (Double(toplamFiyat) - ((Double(toplamFiyat) * indirimOrani) / 100.0))
        self.indirimliFiyatLabel.text = "\(Int(indirimliFiyat))₺"
       
        
            self.sepetTutariLabel.text = "\(toplamFiyat)₺"
            
            toplamFiyat = Int(indirimliFiyat)

        }
    }
}


extension SepetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let urun = sepetList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepetCell", for: indexPath) as! SepetUrunTableViewCell
        cell.urunLabel.text = urun.yemek_adi
        cell.adetLabel.text = urun.yemek_siparis_adet
        cell.urun = urun
        cell.sepetPresenterNesnesi = sepetPresenterNesnesi
        cell.fiyatLabel.text = "\(urun.yemek_fiyat!)₺"
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(urun.yemek_resim_adi!)")
        cell.urunImageView.kf.setImage(with: url)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
