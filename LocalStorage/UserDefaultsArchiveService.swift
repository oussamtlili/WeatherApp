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
    
    public func store(weathers: [Weather]) {
        let encoder = JSONEncoder()
        if let encodedWeathers = try? encoder.encode(weathers) {
            UserDefaults.standard.set(encodedWeathers, forKey: Constants.weathersArchiveKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    public  func retriveWeathers() -> [Weather]? {
        let decoder = JSONDecoder()
        guard let encodedWeathers = UserDefaults.standard.data(forKey: Constants.weathersArchiveKey),
            let weathers = try? decoder.decode([Weather].self, from: encodedWeathers) else {
                return nil
        }
        return weathers
    }
}

// MARK : - Constatns

private extension UserDefaultsArchiveService {
    enum Constants {
        static let weathersArchiveKey = "weathersArchiveKey"
    }
}
