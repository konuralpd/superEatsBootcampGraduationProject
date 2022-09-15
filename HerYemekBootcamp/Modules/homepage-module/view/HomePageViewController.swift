//
//  HomePageViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import UIKit



class HomePageViewController: UIViewController {

    var gelenData: Array<Yemek>?
    var gelenKullaniciAdi: String?
    var homePresenterNesnesi: ViewToPresenterHomeProtocol?

    @IBOutlet weak var kullaniciAdilabel: UILabel!
    @IBOutlet weak var sepetimButton: UITabBarItem!
    
    @IBOutlet weak var anasayfaTabItem: UITabBarItem!
    @IBOutlet weak var kampanyaView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
  
    
    
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    
    
    @IBOutlet weak var restorantTableView: UITableView!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0
    var sepetList = [Sepet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

     navigationTasarimi()
        
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        
        restorantTableView.delegate = self
        restorantTableView.dataSource = self
        
        blurEnd()
        createOnboradingSliders()
        
        kullaniciAdilabel.text = gelenKullaniciAdi //Giris sayfasından gelen kullanıcı bilgisi.
        HomeRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homePresenterNesnesi?.sepetTutari(kullanici_adi: gelenKullaniciAdi!)
        homePresenterNesnesi?.sepetiGetir(kullanici_adi: gelenKullaniciAdi!)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRestaurantVC"{
            let gidenData = sender as! (data: Optional<Array<Yemek>>, kullanici: Optional<String>)
            let destinationVC = segue.destination as! MenuVC
            destinationVC.gelenData = gidenData.data
            destinationVC.gelenKullaniciAdi = gelenKullaniciAdi
            destinationVC.sepetList = sepetList
        }

    }
    
    
    func navigationTasarimi() {
        navigationItem.hidesBackButton = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = (UIColor.white)
        let titleAttribute = [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColor")]
        appearance.titleTextAttributes = titleAttribute as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    
    }
    
    func createOnboradingSliders() {
        slides = [
            OnboardingSlide(title: "", description: "", image: UIImage(named: "carousel2")!),
            OnboardingSlide(title: "", description: "", image: UIImage(named: "carousel3")!), OnboardingSlide(title: "",description: "", image: UIImage(named: "carousel1")!)
        ]
    }
    
    func blurEnd() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
            blurView.isHidden = true
        }
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toProfile", sender: nil)
    }
    
}

extension HomePageViewController: PresenterToViewHomeProtocol {
    func vieweSepetAdetVeriGonder(sepet: Array<Sepet>) {
        self.sepetList = sepet
        if sepet.count > 0 {
            sepetimButton.badgeValue = "\(sepetList.count)"
        } else {
            self.sepetimButton.badgeValue = nil
        }
    }
    
    func viewaVeriGonder(tutar: Int) {
        
    }
    

}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CarouselCollectionViewCell
        cell.setup(slides[indexPath.row])
        cell.carouselImageView.contentMode = .scaleToFill
        cell.carouselImageView.autoresizingMask = .flexibleWidth
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension HomePageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restorantCell", for: indexPath) as! RestorantTableViewCell
         return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gidenData = (data:gelenData, kullanici:gelenKullaniciAdi)
        performSegue(withIdentifier: "toRestaurantVC", sender: gidenData)
        restorantTableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    
}
