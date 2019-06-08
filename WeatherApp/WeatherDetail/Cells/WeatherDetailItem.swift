//
//  WeatherDetailItem.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi

struct WeatherDetailItem {
    
    // MARK: - Init
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    // MARK: - Public Attributes
    
    var time: String? {
        guard let date = weather.date else {
            return nil
        }
        
        return DateFormatter.weatherTimeFormatter().string(from: date)
    }
    
    var temperature: String {
        guard let celsiusTemperature = weather.temperatureInCelsius else {
            return NSLocalizedString("Commun.TemperatureDefaultMessage", comment: "")
        }
        return celsiusTemperature.formattedTemperature
    }
    
    var riskOfRain: String {
        return weather.pluie > 0 ? NSLocalizedString("Commun.Rain", comment: "") : NSLocalizedString("Commun.NotRain", comment: "")
    }
    
    var riskOfSnow: String {
        return weather.risqueNeige == .oui ? NSLocalizedString("Commun.Snow", comment: "") : NSLocalizedString("Commun.NotSnow", comment: "")
    }
    
    // MARK:- Private Attributes
    
    let weather: Weather
}
