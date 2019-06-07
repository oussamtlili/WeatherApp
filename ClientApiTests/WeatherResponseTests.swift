//
//  WeatherResponseTests.swift
//  ClientApiTests
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import XCTest
@testable import ClientApi

class WeatherResponseTests: XCTestCase {
    
    // MARK: - Tests
    
    func testWeatherResponseValid() {
        // Given
        let responseStatus = 200
        let weatherResponse = givenWeatherResponse(requestState: responseStatus)
        
        // When
        let result = weatherResponse.status
        
        // Then
        XCTAssertEqual(result, .valid)
    }
    
    func testWeatherResponseBandwidthLimitExceeded() {
        // Given
        let responseStatus = 509
        let weatherResponse = givenWeatherResponse(requestState: responseStatus)
        
        // When
        let result = weatherResponse.status
        
        // Then
        XCTAssertEqual(result, .bandwidthLimitExceeded)
    }
    
    func testWeatherResponseBadRequest() {
        // Given
        let responseStatus = 400
        let weatherResponse = givenWeatherResponse(requestState: responseStatus)
        
        // When
        let result = weatherResponse.status
        
        // Then
        XCTAssertEqual(result, .badRequest)
    }
    
    func testWeatherResponseConflict() {
        // Given
        let responseStatus = 409
        let weatherResponse = givenWeatherResponse(requestState: responseStatus)
        
        // When
        let result = weatherResponse.status
        
        // Then
        XCTAssertEqual(result, .conflict)
    }
    
    func testWeatherResponseUnkonw() {
        // Given
        let responseStatus = 201
        let weatherResponse = givenWeatherResponse(requestState: responseStatus)
        
        // When
        let result = weatherResponse.status
        
        // Then
        XCTAssertEqual(result, .unkonw)
    }
    
    // MARK: - Private methods
    private func givenWeatherResponse(requestState: Int = 200,
                                      requestKey: String? = nil ,
                                      message: String = "OK",
                                      modelRun: String? = nil,
                                      source:String? = nil,
                                      weathers: [Weather]? = nil) -> WeatherResponse {
        return WeatherResponse(
            requestState: requestState,
            requestKey: requestKey,
            message: message,
            modelRun: modelRun,
            source: source,
            weathers: weathers)
    }

}
