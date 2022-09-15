//
//  ViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 1.09.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.isHidden = false
                nextButton.setTitle("Harika! Başlayalım", for: .normal)
            } else {
                nextButton.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        
        slides = [
            OnboardingSlide(title: "Binlerce Çeşit", description: "Super Eats'te pizzadan kebaba, sushiden mantıya kadar binlerce çeşit ürün ve yemeği tek tıkla şipariş edebilirsin!", image: UIImage(named: "onboarding1")!),
        OnboardingSlide(title: "Hızlı Teslimat", description: "Siparişin en geç 30 dakika içerisinde teslim edilir. Hava koşullarına göre teslimat süresinde gecikmeler olabilir.", image: UIImage(named: "onboarding2")!),
            OnboardingSlide(title: "Güvenli Ödeme", description: "İstersen kredi kartınla istersen kapıda nakit olarak siparişlerini güvenli şekilde öde.", image: UIImage(named: "onboarding3")!)
        
        ]
        nextButton.isHidden = true
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
       
    }
    
    
    }

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        cell.slideImageView.contentMode = .scaleAspectFit
        cell.slideImageView.autoresizingMask = .flexibleHeight
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
       
    }
}

    


