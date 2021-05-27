//
//  LocationManager.swift
//  Yelper
//
//  Created by Duong Nguyen on 5/26/21.
//

import CoreLocation

class LocationManager: ObservableObject, CLLocationManagerDelegate {
    var didChange = PassthroughSubject<NetworkManager, Never>()

    
    @Published var center: NetworkResult = NetworkResult(businesses: [], region: Region(center: Center(latitude: 33.7886375, longitude: -117.9632285))) {
        didSet {
            didChange.send(self)
        }
    }
    
    let manager = CLLocationManager()

    init() {
        manager.delegate = self
    }

    func getCurrentLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            center = Center(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}
