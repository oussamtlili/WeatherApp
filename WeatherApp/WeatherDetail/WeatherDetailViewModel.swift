//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi

class WeatherDetailViewModel: NSObject {
    
    // MARK: - Init
    
    init(weathersItem: WeatherItem) {
        self.weatherItem = weathersItem
    }
    
    // MARK: - Public attributes
    
    var pageTitle: String {
        return DateFormatter.weatherDateFormatter().string(from: weatherItem.date)
    }
    
    // MARK: - Private attributes
    
    private let weatherItem: WeatherItem
}

extension WeatherDetailViewModel: WeatherDetailTableViewDataProvider {
    func getData() -> [WeatherDetailItem] {
        return weatherItem.weathers
            .filter({ $0.date != nil})
            .sorted(by:{ $0.date! < $1.date! })
            .map { WeatherDetailItem(weather: $0) }
    }
}
