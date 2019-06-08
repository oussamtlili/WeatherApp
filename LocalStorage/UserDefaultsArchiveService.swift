//
//  UserDefaultsArchiveService.swift
//  LocalStorage
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi

public struct UserDefaultsArchiveService: ArchiveService {
    
    // MARK : - Public Methods
    
    public init() {}
    
    public func store(weathers: [Weather]?) {
        guard let weathers = weathers else {
            return
        }
        insert(object: weathers, key: Constants.weathersArchiveKey)
    }
    
    public  func retriveWeathers() -> [Weather]? {
        return retreive(key: Constants.weathersArchiveKey)
    }
    
    public func store(cityName: String?) {
        guard let cityName = cityName else {
            return
        }
        insert(object: cityName, key: Constants.cityNameArchiveKey)
    }
    
    public func retriveCityName() -> String? {
        return retreive(key: Constants.cityNameArchiveKey)
    }
    
    private func insert<T: Encodable>(object: T, key: String) {
        let encoder = JSONEncoder()
        if let encodedObject = try? encoder.encode(object) {
            UserDefaults.standard.set(encodedObject, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    private func retreive<T: Decodable>(key: String) -> T? {
        let decoder = JSONDecoder()
        guard let encodedObject = UserDefaults.standard.data(forKey: key),
            let decodedObject = try? decoder.decode(T.self, from: encodedObject) else {
                return nil
        }
        return decodedObject
    }
}

// MARK : - Constatns

private extension UserDefaultsArchiveService {
    enum Constants {
        static let weathersArchiveKey = "weathersArchiveKey"
        static let cityNameArchiveKey = "cityNameArchiveKey"
    }
}
