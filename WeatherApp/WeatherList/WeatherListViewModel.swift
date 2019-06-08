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
import LocalStorage

class WeatherListViewModel {
    
    public init(weatherApiClient: WeatherApiClient = WeatherApiClient(),
                locationService: LocationService = LocationService(),
                archiveService: ArchiveService = UserDefaultsArchiveService()) {
        self.weatherApiClient = weatherApiClient
        self.locationService = locationService
        self.archiveService = archiveService
    }
    
    // MARK - Public attributes
    
    var pageTitle: String = NSLocalizedString("WeatherList.defaultTitle", comment: "") {
        didSet {
            didUpdatePageTitle?(pageTitle)
        }
    }
    
    var didUpdatePageTitle: ((_ pageTitle: String) -> Void)?
    
    var didFailToRetreiveUserLocation: ((_ error: LocationError) -> Void)?
    
    var didFailToRetreiveWeather:((_ canLoadFromCache: Bool) -> Void)?
    
    var didSucceedToRetreiveWeather:(() -> Void)?
    
    // MARK - Private attributes
    
    private let weatherApiClient: WeatherApiClient
    private let locationService: LocationService
    private let archiveService: ArchiveService
    
    // MARK - Public methods
    
    public func loadWeatherInformations() {
        getUserCurrentPositon()
    }
    
    public func loadParisWeatherInformations() {
        self.updatePageTitle(cityName: NSLocalizedString("Commun.Paris", comment: ""))
        getWeather(
            longitude: Constans.parisLongitude,
            latitue: Constans.parisLongitude,
            cityName: NSLocalizedString("Commun.Paris", comment: ""))
    }
    
    // MARK - Private methods
    private func getUserCurrentPositon() {
        locationService.startRetriveLocation()
        locationService.didRetreiveLocation = { [weak self] (longitude, latitude, cityName) in
            guard let `self` = self else { return }
            self.updatePageTitle(cityName: cityName)
            self.getWeather(longitude: longitude, latitue: latitude, cityName: cityName)
            
        }
        
        locationService.didFailToRetreiveLocation = {[weak self] (locationError) in
            self?.didFailToRetreiveUserLocation?(locationError)
        }
    }
    
    
    private func getWeather(longitude: Double, latitue: Double, cityName: String?) {
        weatherApiClient.requestWeather(
            with: longitude,
            and: latitue) { [weak self] (weatherResponse, error) in
                guard let `self` = self else { return }
                if let weatherResponse = weatherResponse,
                    weatherResponse.status == .valid {
                    self.succeedToRetreiveWeather(weathers: weatherResponse.weathers, cityName: cityName)
                } else {
                    self.failedToRetreiveWeather()
                }
        }
    }
    
    private func succeedToRetreiveWeather(weathers: [Weather]?, cityName: String?) {
        archiveService.store(cityName: cityName)
        archiveService.store(weathers: weathers)
        didSucceedToRetreiveWeather?()
    }
    
    private func failedToRetreiveWeather() {
        let cachedWeathers = archiveService.retriveWeathers()
        let cachedCityName = archiveService.retriveCityName()
        didFailToRetreiveWeather?(cachedWeathers != nil)
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
