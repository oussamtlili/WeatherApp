//
//  DateFormatter+UI.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

extension DateFormatter {
    public static func weatherDateFormatter(locale: Locale = Locale.current, timeZone: TimeZone = TimeZone.current) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter
    }

}
