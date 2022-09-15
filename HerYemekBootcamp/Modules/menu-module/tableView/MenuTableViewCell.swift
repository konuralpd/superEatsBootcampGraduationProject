//
//  MenuTableViewCell.swift
//  HerYemekBootcamp
//
//  Created by Mac on 3.09.2022.
//

import UIKit
import Kingfisher

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var urunImage: UIImageView!
    @IBOutlet weak var urunlabel: UILabel!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var ekliMiButton: UIButton!
    
    var gelenData: Array<Yemek>?
    var gelenKullaniciAdi: String?
    var secilenYemek:Yemek?
    var sepetList = [Sepet]()
    
    var MenuPresenterNesnesi: ViewToPresenterMenuProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    

    @IBAction func ekleButtonClicked(_ sender: Any) {
       
    }
    
    
}
