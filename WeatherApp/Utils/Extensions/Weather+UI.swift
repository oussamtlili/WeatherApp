//
//  Weather+UI.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi

// MARK: - computed model properties

public extension Weather {
    var temperatureInCelsius: Double? {
        guard let temperatureInKelvin = temperature.values[Constants.temperatureField] else {
            return nil
        }
        
        return temperatureInKelvin.celsiusFromKelvin.rounded()
    }
    
    var dateIngoringTime: Date {
        guard let date = date,
            let dateWithoutTime = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: date)) else {
            fatalError("Failed to strip time from Date")
        }
        return dateWithoutTime
    }
}

// MARK: - Constants
private extension Weather {
    enum Constants {
        static let temperatureField = "2m"
    }
}

