//
//  WeatherItemTests.swift
//  WeatherAppTests
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import XCTest
import ClientApi
@testable import WeatherApp

class WeatherItemTests: XCTestCase {
    private let weatherMock = WeatherMock()
    
    func testWeatherItemFormattedDate() {
        // Given
        let dateString = "2019-06-08T10:00:00"
        let date: Date = DateFormatter.testDateFormatter().date(from: dateString)!
        
        // When
        let result = WeatherItem(weathers: [], date: date)
        
        // Then
        XCTAssertEqual(result.formattedDate, "8 juin 2019")
    }
    
    func testMintTemperatureEmptyWeathers() {
        // Given
        let weathers: [Weather] = []
        
        // When
        let result = WeatherItem(weathers: weathers, date: Date())
        
        // Then
        XCTAssertEqual(result.minTemperature, NSLocalizedString("Commun.TemperatureDefaultMessage", comment: ""))
    }
    
    func testMinTemperatureWeathersWithoutTemperature() {
        // Given
        let weathers: [Weather] = [weatherMock.anyWeather(),
                                   weatherMock.anyWeather(),
                                   weatherMock.anyWeather()]
        
        // When
        let result = WeatherItem(weathers: weathers, date: Date())
        
        // Then
        XCTAssertEqual(result.minTemperature, NSLocalizedString("Commun.TemperatureDefaultMessage", comment: ""))
    }
    
    func testMinTemperatureWeathersWithTemperature() {
        // Given
        let firstTemperature = DynamicKeys(values: ["2m" : 300])
        let secondTemperature = DynamicKeys(values: ["2m" : 250])
        let thirdTemperature = DynamicKeys(values: ["2m" : 280])
        let weathers: [Weather] = [weatherMock.anyWeather(temperature: firstTemperature),
                                   weatherMock.anyWeather(temperature: secondTemperature),
                                   weatherMock.anyWeather(temperature: thirdTemperature)]
        
        // When
        let result = WeatherItem(weathers: weathers, date: Date())
        
        // Then
        XCTAssertEqual(result.minTemperature, "-23°c")
    }
    
    func testMinTemperatureWeathersMixedTemperature() {
        // Given
        let firstTemperature = DynamicKeys(values: ["2m" : 300])
        let secondTemperature = DynamicKeys(values: ["5m" : 250])
        let thirdTemperature = DynamicKeys(values: ["2m" : 280])
        let weathers: [Weather] = [weatherMock.anyWeather(temperature: firstTemperature),
                                   weatherMock.anyWeather(temperature: secondTemperature),
                                   weatherMock.anyWeather(temperature: thirdTemperature)]
        
        // When
        let result = WeatherItem(weathers: weathers, date: Date())
        
        // Then
        XCTAssertEqual(result.minTemperature, "7°c")
    }
    
    func testMaxTemperatureWeathersWithoutTemperature() {
        // Given
        let weathers: [Weather] = [weatherMock.anyWeather(),
                                   weatherMock.anyWeather(),
                                   weatherMock.anyWeather()]
        
        // When
        let result = WeatherItem(weathers: weathers, date: Date())
        
        // Then
        XCTAssertEqual(result.minTemperature, NSLocalizedString("Commun.TemperatureDefaultMessage", comment: ""))
    }
    
    func testMaxTemperatureWeathersWithTemperature() {
        // Given
        let firstTemperature = DynamicKeys(values: ["2m" : 300])
        let secondTemperature = DynamicKeys(values: ["2m" : 310])
        let thirdTemperature = DynamicKeys(values: ["2m" : 280])
        let weathers: [Weather] = [weatherMock.anyWeather(temperature: firstTemperature),
                                   weatherMock.anyWeather(temperature: secondTemperature),
                                   weatherMock.anyWeather(temperature: thirdTemperature)]
        
        // When
        let result = WeatherItem(weathers: weathers, date: Date())
        
        // Then
        XCTAssertEqual(result.maxTemperature, "37°c")
    }
    
    func testMaxTemperatureWeathersMixedTemperature() {
        // Given
        let firstTemperature = DynamicKeys(values: ["2m" : 300])
        let secondTemperature = DynamicKeys(values: ["2m" : 250])
        let thirdTemperature = DynamicKeys(values: ["5m" : 280])
        let weathers: [Weather] = [weatherMock.anyWeather(temperature: firstTemperature),
                                   weatherMock.anyWeather(temperature: secondTemperature),
                                   weatherMock.anyWeather(temperature: thirdTemperature)]
        
        // When
        let result = WeatherItem(weathers: weathers, date: Date())
        
        // Then
        XCTAssertEqual(result.maxTemperature, "27°c")
    }
}
