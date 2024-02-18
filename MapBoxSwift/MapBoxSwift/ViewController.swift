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
        draMarker(at: defaultCoordinate)
    }

    fileprivate func setupMapBox() {
        mapView = MapView(frame: view.bounds)
        let defaultCameraOptions = CameraOptions(center: defaultCoordinate, zoom: 15, bearing: 0, pitch: 0)
        mapView.mapboxMap.setCamera(to: defaultCameraOptions)
        view.addSubview(mapView)
    }
    
    fileprivate func draMarker(at someCoordinate: CLLocationCoordinate2D) {
        // Initialize a point annotation with a CLLocationCoordinate2D
        var pointAnnotation = PointAnnotation(coordinate: someCoordinate)

        // Make the annotation show a red pin
        pointAnnotation.image = .init(image: UIImage(named: "dest-pin")!, name: "dest-pin")
        pointAnnotation.iconSize = 0.04

        // Create the `PointAnnotationManager`, which will be responsible for handling this annotation
        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()

        // Add the annotation to the manager in order to render it on the map.
        pointAnnotationManager.annotations = [pointAnnotation]
    }
}

