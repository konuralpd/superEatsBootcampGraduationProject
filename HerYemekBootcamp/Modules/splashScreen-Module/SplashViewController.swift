//
//  SplashViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 5.09.2022.
//

import UIKit

class SplashViewController: UIViewController {

    
    
    @IBOutlet weak var blurView4: UIImageView!
    @IBOutlet weak var blurView3: UIImageView!
    @IBOutlet weak var blurView2: UIImageView!
    @IBOutlet weak var splashGif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let splash = UIImage.gifImageWithName("supereats")
        splashGif?.image = splash
        let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
animateBlurs()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func animateBlurs() {
        blurView2.alpha = 0
        UIView.animate(withDuration: 2.25){ [self] in
        blurView2.alpha = 1
        }
        
        blurView2.alpha = 0
        UIView.animate(withDuration: 2.5){ [self] in
            blurView2.alpha = 1
        }
        blurView3.alpha = 0
        UIView.animate(withDuration: 2.5){ [self] in
            blurView3.alpha = 1
        }
        
        blurView4.alpha = 0
        UIView.animate(withDuration: 2.5){ [self] in
            blurView4.alpha = 1
        }
    }
    @objc func timeToMoveOn() {
            self.performSegue(withIdentifier: "toOnboard", sender: self)
        }
    }
