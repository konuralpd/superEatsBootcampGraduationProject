//
//  CarouselCollectionViewCell.swift
//  HerYemekBootcamp
//
//  Created by Mac on 2.09.2022.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var carouselImageView: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    func setup(_ slide: OnboardingSlide) {
        carouselImageView.image = slide.image
    }
    
}
