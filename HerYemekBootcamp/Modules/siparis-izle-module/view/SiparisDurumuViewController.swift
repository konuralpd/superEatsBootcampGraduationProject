//
//  SiparisDurumuViewController.swift
//  HerYemekBootcamp
//
//  Created by Mac on 5.09.2022.
//

import UIKit
import CoreLocation
import MapKit

class SiparisDurumuViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var lm = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
        lm.delegate = self
        
    }
    
    @IBAction func backToHomeClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true) //Anasayfaya don
    }
    
}

extension SiparisDurumuViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sonKonum = locations[locations.count-1]

        
        let konum = CLLocationCoordinate2D(latitude: sonKonum.coordinate.latitude, longitude: sonKonum.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let bolge = MKCoordinateRegion(center: konum, span: span)
        mapView.setRegion(bolge, animated: true)
    
        mapView.showsUserLocation = true
    }
}

