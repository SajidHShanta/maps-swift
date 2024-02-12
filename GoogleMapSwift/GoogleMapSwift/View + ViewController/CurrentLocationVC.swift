//
//  CurrentLocationVC.swift
//  GoogleMapSwift
//
//  Created by Sajid Shanta on 12/2/24.
//

import UIKit
import GoogleMaps
import CoreLocation

class CurrentLocationVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Current Location"
        
        getUserLocation()
        setupMap()
    }
    
    /// Set up Google Maps view
    fileprivate func setupMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 15.0)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    fileprivate func getUserLocation() {
        // Set up location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension CurrentLocationVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {        
        guard let location = locations.last else { return }
        
        mapView.animate(to: GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15.0))
        
        mapView.clear()
        // Creates a marker
        let marker = GMSMarker()
        marker.position = location.coordinate
        
        location.reverseGeocoding { locationName in
            print("\(locationName)")
            marker.title = locationName
        }
//        marker.snippet = "BK Banani"
        marker.map = mapView
        
    }
}
