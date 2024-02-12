//
//  PolygonVC.swift
//  GoogleMapSwift
//
//  Created by Sajid Shanta on 12/2/24.
//

import UIKit
import GoogleMaps

class PolygonVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Polygon Draw"
    }

}
