//
//  LocationManager.swift
//  Yelper
//
//  Created by Duong Nguyen on 5/26/21.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var didChange = PassthroughSubject<LocationManager, Never>()

    private let locationManager = CLLocationManager()
    
    @Published var status: CLAuthorizationStatus? {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var location: CLLocation? {
        didSet {
            didChange.send(self)
        }
    }
    @Published var coordinate: Center? {
        didSet {
            didChange.send(self)
        }
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            self.coordinate = Center(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}
