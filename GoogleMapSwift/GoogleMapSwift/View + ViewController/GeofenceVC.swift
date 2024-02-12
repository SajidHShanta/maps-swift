//
//  GeofenceVC.swift
//  GoogleMapSwift
//
//  Created by Sajid Shanta on 12/2/24.
//

import UIKit
import GoogleMaps
import CoreLocation

class GeofenceVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var markers: [GMSMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Geofence"
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        DispatchQueue.main.async {
            self.locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    private func setupGeofencing() {
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
            showAlert(message: "Geofencing is not supported on this device")
            return
        }
        
        guard CLLocationManager.authorizationStatus() == .authorizedAlways ||  CLLocationManager.authorizationStatus() == .authorizedWhenInUse else {
            showAlert(message: "App does not have correct location authorization")
            return
        }
        
        startMonitoring()
    }
    
    private func startMonitoring() {
        let regionCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.3346438, longitude: -122.008972)
        mapView.camera = GMSCameraPosition(target: regionCoordinate, zoom: 15.0)
        let geofenceRegion: CLCircularRegion = CLCircularRegion(
            center: regionCoordinate,
            radius: 100, // Radius in Meter
            identifier: "apple_park" // unique identifier
        )
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        // Draw geofence on the map
        drawGeofenceOverlay(center: regionCoordinate, radius: geofenceRegion.radius)
        
        // Start monitoring
        locationManager.startMonitoring(for: geofenceRegion)
    }
    
    private func drawGeofenceOverlay(center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        // Create a circle overlay
        let circle = GMSCircle(position: center, radius: radius)
        circle.fillColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.3) // Set fill color
        circle.strokeColor = .blue // Set stroke color
        circle.strokeWidth = 2 // Set stroke width
        circle.map = mapView // Add circle to the map
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension GeofenceVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let region = region as? CLCircularRegion else { return }
        showAlert(message: "User enter \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard let region = region as? CLCircularRegion else { return }
        showAlert(message: "User leave \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("When user did not yet determined")
        case .restricted:
            print("Restricted by parental control")
        case .denied:
            print("When user select option Dont't Allow")
        case .authorizedAlways:
            print("Geofencing feature has user permission")
            setupGeofencing()
        case .authorizedWhenInUse:
            print("Geofencing feature has user permission")
            setupGeofencing()
        default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else {
            return
        }
        mapView.animate(to: GMSCameraPosition.camera(withTarget: latestLocation.coordinate, zoom: 15.0))
        
        markers.forEach { marker in
            marker.map = nil
        }
        markers.removeAll()
        
        // Creates a marker
        let marker = GMSMarker()
        marker.position = latestLocation.coordinate
        
        latestLocation.reverseGeocoding { locationName in
            print("\(locationName)")
            marker.title = locationName
        }
        marker.map = mapView
        markers.append(marker)
    }
    
    ///Handling Geofencing Error
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        guard let region = region else {
            print("The region could not be monitored, and the reason for the failure is not known.")
            return
        }
        
        print("There was a failure in monitoring the region with a identifier: \(region.identifier)")
    }
    
}
