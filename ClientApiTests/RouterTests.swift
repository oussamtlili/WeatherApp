//
//  RouterTests.swift
//  WeatherAppTests
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import XCTest
@testable import ClientApi

class RouterTests: XCTestCase {
    
    // MARK: - Tests
    
    func testGetWeatherUrl() {
        // Given
        let longitude = 44.5643
        let latitude = 52.345
        
        // When
        let getWeatherUrl = try! Router.getWheathers(longitude: longitude, lattitude: latitude).requestUrl()
        
        // Then
        let expectedUrlString = "http://www.infoclimat.fr/public-api/gfs/json?_ll=52.345,44.5643&_auth=Bx1RRlYoUXNSfwYxA3VQeQdvVGENewgvB3tRMgpvUy4Eb1MyUzNTNVc5A35XeAQyVXgEZwoxBzcKYVAoAHIEZQdtUT1WPVE2Uj0GYwMsUHsHKVQ1DS0ILwdlUT4KYlMuBGVTNlM0Uy9XPQNjV3kEMVV5BHsKNAc6CmpQMABtBGYHZFE8Vj1RNVIiBnsDNlA2Bz1UZw1nCGQHZlFnCjJTMQQxUzJTZlM3VyYDY1dvBDVVYwRtCjMHPwpgUCgAcgQeBxdRKFZ1UXFSaAYiAy5QMQdqVGA%3D&_c=6967d2789c12b45bbec4476bc7704087"
        let expectedResult = URL(string: expectedUrlString)
        XCTAssertEqual(getWeatherUrl, expectedResult)
    }
}
