//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi
import Location

class WeatherListViewModel {
    
    public init(weatherApiClient: WeatherApiClient = WeatherApiClient(),
                locationService: LocationService = LocationService()) {
        self.weatherApiClient = weatherApiClient
        self.locationService = locationService
    }
    
    // MARK - Public attributes
    
    var pageTitle: String = NSLocalizedString("WeatherList.defaultTitle", comment: "") {
        didSet {
            didUpdatePageTitle?(pageTitle)
        }
    }
    
    var didUpdatePageTitle: ((_ pageTitle: String) -> Void)?
    
    var didFailToRetreiveUserLocation: ((_ error: LocationError) -> Void)?
    
    // MARK - Private attributes
    
    private let weatherApiClient: WeatherApiClient
    private let locationService: LocationService
    
    // MARK - Public methods
    
    public func loadWeatherInformations() {
        getUserCurrentPositon()
    }
    
    public func loadParisWeatherInformations() {
        pageTitle = NSLocalizedString("Commun.Paris", comment: "")
        getWeather(longitude: Constans.parisLongitude, latitue: Constans.parisLongitude)
    }
    
    // MARK - Private methods
    private func getUserCurrentPositon() {
        locationService.startRetriveLocation()
        locationService.didRetreiveLocation = { [weak self] (longitude, latitude, cityName) in
            guard let `self` = self else { return }
            self.updatePageTitle(cityName: cityName)
            self.getWeather(longitude: longitude, latitue: latitude)
            
        }
        
        locationService.didFailToRetreiveLocation = {[weak self] (locationError) in
            self?.didFailToRetreiveUserLocation?(locationError)
        }
    }
    
    
    private func getWeather(longitude: Double, latitue: Double) {
        weatherApiClient.requestWeather(with: longitude, and: latitue) { (weatherResponse, error) in
            
        }
    }
    
    private func updatePageTitle(cityName: String?) {
        if  let cityName = cityName {
            pageTitle = cityName
        } else {
            pageTitle = NSLocalizedString("WeatherList.defaultTitle", comment: "")
        }
    }
}


// MARK: - Constans
private extension WeatherListViewModel {
    enum  Constans {
        static let parisLongitude: Double = 2.3488
        static let parisLatitude: Double = 48.8534
    }
}
