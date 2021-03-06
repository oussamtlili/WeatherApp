//
//  WeatherApiClient.swift
//  ClientApi
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

public struct WeatherApiClient {
    
    // MARK: - init
    public init() {}
    
    // MARK: - Private attributes
    private let clientAPI = ClientApi()
    
    // MARK: - Public methods
    public func requestWeather(
        with longitude: Double,
        and latitude: Double,
        completion: @escaping (_ response :WeatherResponse? ,_ error :Error?)->Void) {
        do {
            let url = try Router.getWheathers(longitude: longitude, lattitude: latitude).requestUrl()
            clientAPI.getData(from: url) { (weather, error) in
                completion(weather, error)
            }
        } catch (let error ){
            completion(nil, error)
        }
    }
}
