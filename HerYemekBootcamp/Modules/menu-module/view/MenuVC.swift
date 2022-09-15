//
//  RestaurantViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import UIKit
import ProgressHUD
import Kingfisher
import FirebaseAuth

class MenuVC: UIViewController {
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var sepetUrunAdet: UILabel!
    @IBOutlet weak var ekleButton: UIButton!
    @IBOutlet weak var totalUcretLabel: UILabel!
    @IBOutlet weak var sepetView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
 
    var MenuPresenterNesnesi: ViewToPresenterMenuProtocol?
    
    var gelenData: Array<Yemek>?
    var sepetList = [Sepet]()
    var filtreliUrunler:Array<Yemek>?
    var gelenKullaniciAdi: String?
    var kullaniciAdi = Auth.auth().currentUser?.email!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationTasarimi()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        searchBar.delegate = self
        MenuRouter.createModule(ref: self)
        self.hideKeyboardWhenTappedAround()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MenuPresenterNesnesi?.sepetToplamFiyat(kullanici_adi: kullaniciAdi!)
        MenuPresenterNesnesi?.sepetietir(kullanici_adi: kullaniciAdi!)
        MenuPresenterNesnesi?.getFoodsFromDB()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetayUrun" {
            let gidenData = sender as! (data:Yemek, kullanici_adi:String)
            let destinationVC = segue.destination as! UrunDetayViewController
            destinationVC.gelenKullaniciAdi = gidenData.kullanici_adi
            destinationVC.gelenData = gidenData.data
        }
    }
   
    func sepetteMi(yemek_adi: String) -> Bool {
        for i in sepetList {
            if i.yemek_adi == yemek_adi {
                return true
            }
        }
        return false
    }
    
  
    @IBAction func sepeteGitClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "toSepet", sender: nil)
    }
    
}

extension MenuVC: PresenterToViewMenuProtocol {
    func viewaVeriGonder(Yemekler: Array<Yemek>) {
        self.gelenData = Yemekler
        self.filtreliUrunler = gelenData
        DispatchQueue.main.async {
            self.menuTableView.reloadData()
        }
    }
    
    func viwewaVeriGonder(adet: Int) {

        if adet > 0 {
            self.sepetView.isHidden = false
            totalUcretLabel.alpha = 0
            UIView.animate(withDuration: 2) { [self] in
                totalUcretLabel.alpha = 1
                totalUcretLabel.font = UIFont.boldSystemFont(ofSize: 18)
                self.totalUcretLabel.text = "\(adet)₺"
            }
        } else {
            self.sepetView.isHidden = true
        }
    }
    
    func vieweSepetAdetVeriGonder(sepet: Array<Sepet>) {
        DispatchQueue.main.async { [self] in
            self.sepetList = sepet
            self.menuTableView.reloadData()
            if sepet.count > 0 {
                UIView.animate(withDuration: 1.5) { [self] in
                    sepetView.alpha = 1
                    self.sepetView.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 1.5) { [self] in
                    sepetView.alpha = 0
                    self.sepetView.isHidden = true
                }
            }
            self.sepetUrunAdet.text = "\(self.sepetList.count)"
        }
    }
    
    func navigationTasarimi() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = (UIColor.white)
        let titleAttribute = [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColor")]
        appearance.titleTextAttributes = titleAttribute as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""

    }
    
    }

extension MenuVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
             self.filtreliUrunler = self.gelenData!.filter { yemekler in
                        yemekler.yemek_adi!.lowercased().contains(searchText.lowercased())
                    }

        } else {
            self.filtreliUrunler = self.gelenData
            menuTableView.reloadData()
                }
                menuTableView.reloadData()
    }
}




extension MenuVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtreliUrunler?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secilenYemek = filtreliUrunler?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        let imgUrl = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(secilenYemek?.yemek_resim_adi! ?? "")")
        cell.urunImage.kf.setImage(with: imgUrl)
        cell.urunlabel.text = (secilenYemek?.yemek_adi)
        cell.fiyatLabel.text = (secilenYemek?.yemek_fiyat)! + "₺"
        cell.MenuPresenterNesnesi = MenuPresenterNesnesi
        cell.gelenData = gelenData
        cell.gelenKullaniciAdi = gelenKullaniciAdi
        cell.secilenYemek = secilenYemek
        cell.sepetList = sepetList
  
            if sepetteMi(yemek_adi: (secilenYemek?.yemek_adi)!) {
                cell.ekliMiButton.alpha = 0
                UIView.animate(withDuration: 1){ [self] in
                cell.ekliMiButton.alpha = 1
                }
                cell.ekliMiButton.imageView?.image = UIImage(named: "EklendiButton")
            } else {
                cell.ekliMiButton.imageView?.image = UIImage(named: "EkleButton")
            }
        
      
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gidenData = (data:gelenData![indexPath.row], kullanici_adi:gelenKullaniciAdi!)
        performSegue(withIdentifier: "toDetayUrun", sender: gidenData)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    
}




