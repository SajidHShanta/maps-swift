//
//  PolygonVC.swift
//  GoogleMapSwift
//
//  Created by Sajid Shanta on 12/2/24.
//

import UIKit
import GoogleMaps

class PolygonVC: UIViewController, GMSMapViewDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Polygon Draw"
        setupMap()
    }
    
    fileprivate func setupMap() {
        mapView.delegate = self
        
        // Create a GMSCameraPosition that tells the map to display the location
        let camera = GMSCameraPosition.camera(withLatitude: 23.791119874561975, longitude: 90.40353225006605, zoom: 17)
        mapView.camera = camera
        
        // Creates a marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 23.791119874561975, longitude: 90.40353225006605)
        marker.title = "BK"
        marker.snippet = "BK Banani"
        marker.map = mapView
        
        // draw polyline
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 23.791119874561975, longitude: 90.40353225006605))
        path.add(CLLocationCoordinate2D(latitude: 23.79130050952048, longitude: 90.40199910479149))
        path.add(CLLocationCoordinate2D(latitude: 23.791137981772383, longitude: 90.40109069620814))
        let polyline = GMSPolyline(path: path)
        polyline.map = mapView
        
        // draw rectangle
        let rectanglePath = GMSMutablePath()
        rectanglePath.add(CLLocationCoordinate2D(latitude: 23.791119874561975, longitude: 90.40353225006605))
        rectanglePath.add(CLLocationCoordinate2D(latitude: 23.790923543978405, longitude: 90.403141914213))
        rectanglePath.add(CLLocationCoordinate2D(latitude: 23.790757201685157, longitude: 90.4041711652695))
        rectanglePath.add(CLLocationCoordinate2D(latitude: 23.79126800398737, longitude: 90.40445536009842))
        rectanglePath.add(CLLocationCoordinate2D(latitude: 23.791119874561975, longitude: 90.40353225006605))
        let rectangle = GMSPolyline(path: rectanglePath)
        rectangle.strokeColor = .red
        rectangle.map = mapView
    }
}
