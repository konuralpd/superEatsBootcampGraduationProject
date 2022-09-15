//
//  OdemeViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 4.09.2022.
//

import UIKit
import MapKit
import CoreLocation
import ProgressHUD

class OdemeViewController: UIViewController {
    @IBOutlet weak var kartSahibiTextView: UITextView!
    @IBOutlet weak var kartSahibiTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var odemeOnaylaButton: UIButton!

    var lm = CLLocationManager()
    var OdemePresenterNesnesi: ViewToPresenterOdemeProtocol?
    var sepetList = [Sepet]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        kartSahibiTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                  for: .editingChanged)
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
        lm.delegate = self
        mapView.delegate = self
        MKLocalSearch.Request().region = mapView.region
        odemeOnaylaButton.addTarget(
            self,
            action: #selector(didTapPlaceOrderButton),
            for: .touchUpInside
        )
        
        OdemeRouter.createModule(ref: self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        kartSahibiTextView.text = textField.text
    }
    
    @objc func didTapPlaceOrderButton() {
        guard let kartIsim = kartSahibiTextField.text?.trimmingCharacters(in: .whitespaces),
              !kartIsim.isEmpty else {
            ProgressHUD.showError("Ödemenizin onaylanması için kart sahibi ismi girmeniz gerekmektedir.")
            return
        }
        
        ProgressHUD.show("Ödeme onaylanıyor...")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            ProgressHUD.showSuccess("Ödemeniz onaylandı, paketinize hediye olarak Algida Magnum ekledik. Afiyet Olsun.🍦🍔😍")
            OdemePresenterNesnesi?.sepetiBosalt(sepet: sepetList)
            self.performSegue(withIdentifier: "toSiparisDurumu", sender: nil)
        }
    }
  
    
}

extension OdemeViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        let merkez = CLLocationCoordinate2D(latitude: 40.98334, longitude: 29.03936)
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let bolge = MKCoordinateRegion(center: merkez, span: span)
        mapView.setRegion(bolge, animated: true)
        mapView.showsUserLocation = true
    
        let pin = MKPointAnnotation()
        pin.coordinate = merkez
        pin.title = "Ev Adresim"
        mapView.addAnnotation(pin)
        
        mapView.showsUserLocation = true
    }
    
}
