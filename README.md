# Maps-Swift

**Maps Integration in Swift for iOS App Development**

Explore maps in Swift iOS app development with seamless integration of 
* Google Map and 
* Map Box.

## Google Map

Dive into Google Maps with comprehensive coverage on the following topics:

* **Setup Google Map with Swift**: Get started with ease by setting up Google Maps in Swift project.
* **Current Location**: Integrate and display the user's current location on the map.
* **Polygon Draw**: Master the art of drawing polygons on the map for enhanced visualization.
* **Geofence Draw and In/Out Alert**: Implement geofencing and receive alerts when users enter or exit defined areas.
* **Route Draw**: Enable users to visualize routes with ease using the route drawing feature.

## Map Box

Explore additional mapping capabilities with [Map Box](https://docs.mapbox.com/ios/legacy/maps/guides/) and enhance your app with advanced features.
//TO-DO

## Installation Guide

Follow these simple steps to set up the project effortlessly:

1. **Clone Repository**: Clone this repository and navigate to the project directory.
2. **Pod Installation**: Run `pod install` to seamlessly incorporate the necessary dependencies into your project.

### API Key Setup

To enable the full functionality, make sure to add your API keys. Create a `MapServices` class with the following structure:

```swift
class MapServices {
    static let shared = MapServices()
    
    let kGoogleMapAPIKey = "YOUR_GOOGLE_MAP_API_KEY"
    let kMapBoxAPIKey = "YOUR_MAP_BOX_API_KEY"
    let kPlaceAPIKey = "YOUR_PLACE_API_KEY"
    let kGeocodeAPIKey = "YOUR_GEOCODE_API_KEY"
    let kGeoAPIKey = "YOUR_GEO_API_KEY"
    let kDirectionAPIKey = "YOUR_DIRECTION_API_KEY"
}
```

Replace the placeholder strings with your actual API keys. This ensures a smooth and secure integration of mapping services in your iOS app.
