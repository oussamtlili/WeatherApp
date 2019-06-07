//
//  WeatherResponse.swift
//  ClientApi
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

private enum CodingKeys: String {
    case requestState = "request_state"
    case requestKey = "request_key"
    case message = "message"
    case modelRun = "model_run"
    case source = "source"
    
    static var knonwCodingKeys: [String] {
        return [CodingKeys.requestState.rawValue, CodingKeys.requestKey.rawValue, CodingKeys.message.rawValue, CodingKeys.modelRun.rawValue, CodingKeys.source.rawValue]
    }
}

public struct WeatherResponse: Decodable {
    public let requestState: Int
    public let requestKey: String?
    public let message: String
    public let modelRun: String?
    public let source:String?
    public let weathers: [Weather]?
    
    init (requestState: Int, requestKey: String?, message: String, modelRun: String?, source:String?, weathers: [Weather]?) {
        self.requestState = requestState
        self.requestKey = requestKey
        self.message = message
        self.modelRun = modelRun
        self.source = source
        self.weathers = weathers
    }
    
    public init(from decoder: Decoder) throws {
        guard let requestStateKey = CustomCodingKeys(stringValue: CodingKeys.requestState.rawValue), let messageKey = CustomCodingKeys(stringValue: CodingKeys.message.rawValue) else {
            throw APIError.parsingFail
        }
        
        let decodingContainer = try decoder.container(keyedBy: CustomCodingKeys.self)
        requestState = try decodingContainer.decode(Int.self, forKey: requestStateKey)
        message = try decodingContainer.decode(String.self, forKey: messageKey)

        if let requestCodingKey = CustomCodingKeys(stringValue: CodingKeys.requestKey.rawValue) {
            requestKey = try decodingContainer.decodeIfPresent(String.self, forKey: requestCodingKey)
        } else {
            requestKey = nil
        }

        if let modelRunKey = CustomCodingKeys(stringValue: CodingKeys.modelRun.rawValue) {
            modelRun = try decodingContainer.decodeIfPresent(String.self, forKey: modelRunKey)
        } else {
            modelRun = nil
        }

        if let sourceKey = CustomCodingKeys(stringValue: CodingKeys.source.rawValue) {
            source = try decodingContainer.decodeIfPresent(String.self, forKey: sourceKey)
        } else {
            source = nil
        }

        weathers = try decodingContainer.allKeys
            .filter { (customCodingKey) -> Bool in
                !CodingKeys.knonwCodingKeys.contains(customCodingKey.stringValue)
            }
            .map { (customCodingKey) -> Weather? in
                guard let date = DateFormatter.iso8601CETFormatter.date(from: customCodingKey.stringValue) else {
                    return nil
                }
                var weather = try decodingContainer.decode(Weather.self, forKey: customCodingKey)
                weather.date = date
                return weather
            }
            .compactMap{ $0 }
    }
}

extension WeatherResponse {
    
    
    public enum ResponseStatus {
        case valid
        case unkonw
        case bandwidthLimitExceeded
        case badRequest
        case conflict
    }
    
    public var status: ResponseStatus {
        switch requestState {
        case 200:
            return .valid
        case 509:
            return .bandwidthLimitExceeded
        case 400:
            return .badRequest
        case 409:
            return .conflict
        default:
            return .unkonw
        }
    }
}
