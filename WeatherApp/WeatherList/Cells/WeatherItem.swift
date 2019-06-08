//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi

struct WeatherItem {
    
    // MARK : - Init
    
    init(weathers: [Weather], date: Date) {
        self.weathers = weathers
        self.date = date
    }
    
    // MARK: - Public attributes
    
    var formattedDate: String {
        return DateFormatter.weatherDateFormatter().string(from: date)
    }
    
    var maxTemperature: String {
        let maxTemperatureInCelsius = weathers.compactMap { $0.temperatureInCelsius }.max()
        guard let celsiusTemperature = maxTemperatureInCelsius else {
            return NSLocalizedString("Commun.TemperatureDefaultMessage", comment: "")
        }
        
        return celsiusTemperature.formattedTemperature
    }
    
    var minTemperature: String {
        let minTemperatureInCelsius = weathers.compactMap { $0.temperatureInCelsius }.min()
        
        guard let celsiusTemperature = minTemperatureInCelsius else {
            return NSLocalizedString("Commun.TemperatureDefaultMessage", comment: "")
        }
        
        return celsiusTemperature.formattedTemperature
    }
    
    var riskOfRain: String {
        guard weathers.contains(where: { $0.pluie > 0 }) else {
            return NSLocalizedString("Commun.NotRain", comment: "")
        }
        
        return NSLocalizedString("Commun.Rain", comment: "")
    }
    
    var riskOfSnow: String {
        guard weathers.contains(where: { $0.risqueNeige == .oui }) else {
            return NSLocalizedString("Commun.NotSnow", comment: "")
        }
        
        return NSLocalizedString("Commun.Snow", comment: "")
    }
    
    let weathers: [Weather]
    
    let date: Date
}
