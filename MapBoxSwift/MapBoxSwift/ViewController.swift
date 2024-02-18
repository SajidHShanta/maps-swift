//
//  ViewController.swift
//  MapBoxSwift
//
//  Created by Sajid Shanta on 18/2/24.
//

import UIKit
import MapboxMaps

class ViewController: UIViewController {
    
    var mapView: MapView!
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4057)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMapBox()
    }

    fileprivate func setupMapBox() {
        mapView = MapView(frame: view.bounds)
        let defaultCameraOptions = CameraOptions(center: defaultCoordinate, zoom: 15, bearing: 0, pitch: 0)
        mapView.mapboxMap.setCamera(to: defaultCameraOptions)
        view.addSubview(mapView)
    }
}

