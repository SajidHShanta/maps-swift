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
    var dhakaCoordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4057),
        CLLocationCoordinate2D(latitude: 23.7918, longitude: 90.4069),
        CLLocationCoordinate2D(latitude: 23.7911, longitude: 90.4055),
        CLLocationCoordinate2D(latitude: 23.7904, longitude: 90.4063),
        CLLocationCoordinate2D(latitude: 23.7897, longitude: 90.4072),
        CLLocationCoordinate2D(latitude: 23.7890, longitude: 90.4059),
        CLLocationCoordinate2D(latitude: 23.7883, longitude: 90.4075),
        CLLocationCoordinate2D(latitude: 23.7876, longitude: 90.4067),
        CLLocationCoordinate2D(latitude: 23.7869, longitude: 90.4081),
        CLLocationCoordinate2D(latitude: 23.7862, longitude: 90.4073)
    ]
    var selectedAnnotation: PointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMapBox()
        //        draMarker(at: defaultCoordinate) // single marker
        drawMultipleMarkers(at: dhakaCoordinates) // multiple markers
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
    
    fileprivate func drawMultipleMarkers(at coordinates: [CLLocationCoordinate2D]) {
        let pointAnnotationManager = mapView.annotations.makePointAnnotationManager()
        var pointAnnotations: [PointAnnotation] = []

        for location in coordinates {
            var pointAnnotation = PointAnnotation(coordinate: location)
            pointAnnotation.image = .init(image: UIImage(named: "dest-pin")!, name: "dest-pin")
            pointAnnotation.iconSize = 0.04
            
            pointAnnotation.tapHandler = { context in
                print("tapped point annotation at \(context.coordinate)")

                self.selectedAnnotation = pointAnnotation

                // Update the iconSize  in PointAnnotationManager
                pointAnnotationManager.annotations = pointAnnotationManager.annotations.map { annotation in
                    var tempAnnotation = annotation
                    tempAnnotation.iconSize = (annotation.id == self.selectedAnnotation?.id) ? 0.06 : 0.04
                    return tempAnnotation
                }
                return true
            }
            
            pointAnnotations.append(pointAnnotation)
        }
        
        pointAnnotationManager.annotations = pointAnnotations
    }
}

