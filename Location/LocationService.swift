//
//  LocationService.swift
//  Location
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationService: NSObject {
    
    // MARK: - Public attributes
    
    public var didRetreiveLocation: ((_ longitude: Double, _ Latitude: Double, _ cityName: String?) -> Void)?
    public var didFailToRetreiveLocation: ((_ error: LocationError) -> Void)?
    
    // MARK: - Private attributes
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    // MARK: - Public methods
    
    public func startRetriveLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            checkAuthorization()
        } else {
            didFailToRetreiveLocation?(LocationError.serviceDisabled)
        }
        
    }
    
    // MARK: - Private methods
    
    private func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            didFailToRetreiveLocation?(LocationError.notAuthorized)
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    private func retreiveCityName(location: CLLocation, completion: ((_ cityName: String?) -> Void)?) {
        geocoder.reverseGeocodeLocation(location) { (placeMarkers, error) in
            if let placeMarkers = placeMarkers, let placeMarker = placeMarkers.first {
                completion?(placeMarker.locality)
            } else {
                completion?(nil)
            }
        }
    }
}

// MARK: - LocationService + CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let location = locations.first {
            retreiveCityName(location: location) {[weak self] (cityName) in
                self?.didRetreiveLocation?(
                    location.coordinate.longitude,
                    location.coordinate.latitude,
                    cityName)
            }
        } else {
            didFailToRetreiveLocation?(LocationError.failToRetreiveLocation)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailToRetreiveLocation?(LocationError.failToRetreiveLocation)
        locationManager.stopUpdatingLocation()
    }
}
