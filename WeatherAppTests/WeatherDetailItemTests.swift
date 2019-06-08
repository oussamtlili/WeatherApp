//
//  WeatherDetailItemTests.swift
//  WeatherAppTests
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import XCTest
import ClientApi
@testable import WeatherApp

class WeatherDetailItemTests: XCTestCase {
    
    private let weatherMock = WeatherMock()
    
    func testWeatherDetailItemTimeNil() {
        // Given
        let date: Date? = nil
        let weather = weatherMock.anyWeather(date: date)
        
        // When
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertNil(result.time)
    }
    
    func testWeatherDetailItemTimeNotNil() {
        // Given
        let dateString = "2019-06-08T10:00:00"
        let date: Date = DateFormatter.testDateFormatter().date(from: dateString)!
        let weather = weatherMock.anyWeather(date: date)
        
        // When
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertEqual(result.time!, "10:00")
    }
    
    func testWeatherDetailItemTemperatureDefaultMessage() {
        // Given
        let values: [String: Double] = [:]
        let temperature: DynamicKeys = DynamicKeys(values: values)
        let weather = weatherMock.anyWeather(temperature: temperature)
        
        // When
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertEqual(result.temperature, NSLocalizedString("Commun.TemperatureDefaultMessage", comment: ""))
    }
    
    func testWeatherDetailItemTemperatureFormattedResult() {
        // Given
        let values: [String: Double] = ["2m" : 302.40]
        let temperature: DynamicKeys = DynamicKeys(values: values)
        let weather = weatherMock.anyWeather(temperature: temperature)
        
        // When
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertEqual(result.temperature, "29°c")
    }
    
    func testWeatherDetailItemRiskOfRainPluieZero() {
        //Given
        let pluie: Double = 0
        let weather = weatherMock.anyWeather(pluie: pluie)
        
        // Whenx
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertEqual(result.riskOfRain, NSLocalizedString("Commun.NotRain", comment: ""))
    }
    
    func testWeatherDetailItemRiskOfRainPluiePositive() {
        //Given
        let pluie: Double = 5
        let weather = weatherMock.anyWeather(pluie: pluie)
        
        // When
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertEqual(result.riskOfRain, NSLocalizedString("Commun.Rain", comment: ""))
    }
    
    func testWeatherDetailItemRiskOfRainPluieNegative() {
        //Given
        let pluie: Double = -5
        let weather = weatherMock.anyWeather(pluie: pluie)
        
        // When
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertEqual(result.riskOfRain, NSLocalizedString("Commun.NotRain", comment: ""))
    }
    
    func testWeatherDetailItemRiskOfSnowTrue() {
        // Given
        let risqueNeige: SnowRisk = .oui
        let weather = weatherMock.anyWeather(risqueNeige: risqueNeige)
        
        // When
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertEqual(result.riskOfSnow, NSLocalizedString("Commun.Snow", comment: ""))
    }
    
    func testWeatherDetailItemRiskOfSnowFalse() {
        // Given
        let risqueNeige: SnowRisk = .non
        let weather = weatherMock.anyWeather(risqueNeige: risqueNeige)
        
        // When
        let result = WeatherDetailItem(weather: weather)
        
        // Then
        XCTAssertEqual(result.riskOfSnow, NSLocalizedString("Commun.NotSnow", comment: ""))
    }
}
