//
//  RouteDrawVC.swift
//  GoogleMapSwift
//
//  Created by Sajid Shanta on 12/2/24.
//

import UIKit
import CoreLocation
import GoogleMaps
import Alamofire
import SwiftyJSON

class RouteDrawVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Route Draw"
        
        let sourceCoordinate = CLLocationCoordinate2D(latitude: 23.79172272872744, longitude: 90.40361703068893) // source coordinates
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 23.815534301769443, longitude: 90.4255333591432) // destination coordinates
        
        setupMap(defaultCoordinate: sourceCoordinate)

        getDirections(from: sourceCoordinate, to: destinationCoordinate)
    }
    
    fileprivate func setupMap(defaultCoordinate: CLLocationCoordinate2D) {
//        let camera = GMSCameraPosition.camera(withLatitude: 0.0, longitude: 0.0, zoom: 15.0)
        let camera = GMSCameraPosition.camera(withTarget: defaultCoordinate, zoom: 15.0)

        mapView.camera = camera
    }
    
    func getDirections(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let apiKey = MapServices.shared.kDirectionKey
        let origin = "\(source.latitude),\(source.longitude)"
        let destination = "\(destination.latitude),\(destination.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=\(apiKey)"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.drawRoute(json: json)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func drawRoute(json: JSON) {
        guard let routes = json["routes"].array else {
            return
        }

        for route in routes {
            if let overviewPolyline = route["overview_polyline"].dictionary,
               let points = overviewPolyline["points"]?.string,
               let path = GMSPath(fromEncodedPath: points) {
                
                // Create polyline
                let polyline = GMSPolyline(path: path)
//                polyline.strokeColor = UIColor.blue
                polyline.strokeWidth = 3.0
                polyline.map = mapView
                
                // Set map view camera to fit the drawn route
                fitMapToPolyline(path: path)
            }
        }
    }
    
    func fitMapToPolyline(path: GMSPath) {
        let bounds = GMSCoordinateBounds(path: path)
        
        let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50) // Adjust the insets as needed
        let cameraUpdate = GMSCameraUpdate.fit(bounds, with: insets)
        
        mapView.animate(with: cameraUpdate)
    }
}
