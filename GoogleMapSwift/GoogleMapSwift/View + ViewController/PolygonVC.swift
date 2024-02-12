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
        
        let polylineLocations = [
            CLLocationCoordinate2D(latitude: 23.791119874561975, longitude: 90.40353225006605),
            CLLocationCoordinate2D(latitude: 23.79130050952048, longitude: 90.40199910479149),
            CLLocationCoordinate2D(latitude: 23.791137981772383, longitude: 90.40109069620814),
        ]
        
        let rectangleLocations = [
            CLLocationCoordinate2D(latitude: 23.791119874561975, longitude: 90.40353225006605),
            CLLocationCoordinate2D(latitude: 23.790923543978405, longitude: 90.403141914213),
            CLLocationCoordinate2D(latitude: 23.790757201685157, longitude: 90.4041711652695),
            CLLocationCoordinate2D(latitude: 23.79126800398737, longitude: 90.40445536009842),
            CLLocationCoordinate2D(latitude: 23.791119874561975, longitude: 90.40353225006605),
        ]
        
        drawPolyline(polylineLocations)
        drawRectangle(rectangleLocations)
    }
    
    fileprivate func setupMap() {
        mapView.delegate = self
        
        // Create a GMSCameraPosition that tells the map to display the location
        let camera = GMSCameraPosition.camera(withLatitude: 23.791119874561975, longitude: 90.40353225006605, zoom: 17)
        mapView.camera = camera
        
        // Creates a marker
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 23.791119874561975, longitude: 90.40353225006605)
//        marker.title = "BK"
//        marker.snippet = "BK Banani"
//        marker.map = mapView
    }
    
    func drawPolyline(_ locations : [CLLocationCoordinate2D]) {
        let polylinePath = GMSMutablePath()
        
        for location in locations {
            polylinePath.add(location)
        }
        
        let polyline = GMSPolyline(path: polylinePath)
        polyline.map = mapView
    }
    
    func drawRectangle(_ locations : [CLLocationCoordinate2D]) {
        let rectanglePath = GMSMutablePath()
        
        for location in locations {
            rectanglePath.add(location)
        }
        
        let rectangle = GMSPolyline(path: rectanglePath)
        rectangle.strokeColor = .red
        rectangle.map = mapView
    }
}
