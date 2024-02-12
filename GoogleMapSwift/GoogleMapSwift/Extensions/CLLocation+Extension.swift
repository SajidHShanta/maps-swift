//
//  CLLocation+Extension.swift
//  GoogleMapSwift
//
//  Created by Sajid Shanta on 12/2/24.
//

import UIKit
import CoreLocation
import GoogleMaps

extension CLLocation {
    func reverseGeocoding(completion: @escaping (String) -> Void){
        // Perform reverse geocoding to get the location name
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(self) { (placemarks, error) in
            if let error = error {
//                print("Reverse geocoding error: \(error.localizedDescription)")
//                completion(LocationPermissionStrings.unnamedRoad.localized)
            }
            
            if let placemark = placemarks?.first {
                print("placemark  \(placemark)")
                
                let name = placemark.name ?? "$"
                let subLocality = placemark.subLocality ?? "$"
                let locality = placemark.locality ?? "$"
                let country = placemark.country ?? "$"
            
                var locationName = "\(name),\(subLocality),\(locality),\(country)"
                locationName = locationName.replacingOccurrences(of: ",$", with: "")
                
                if locationName.count > 0{
                    print("Location name: \(locationName)")
                    completion(locationName)
                } else {
                    print("Unable to retrieve location name")
//                    completion(LocationPermissionStrings.unnamedRoad.localized)
                }
            }
        }
    }
}
