//
//  DynamicKeys.swift
//  ClientApi
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

public struct DynamicKeys: Codable {
    public let values: [String: Double]
    
    public init(from decoder: Decoder) throws {
        let decodingContainer = try decoder.container(keyedBy: CustomCodingKeys.self)
        
        var result = [String: Double]()
        decodingContainer.allKeys.forEach{
            let value = try? decodingContainer.decode(Double.self, forKey: $0)
            result[$0.stringValue] = value
        }
        
        values = result
    }
    
    public func encode(to encoder: Encoder) throws {
        var encodingContainer = encoder.container(keyedBy: CustomCodingKeys.self)
        
        values.forEach {
            if let customCodingKey = CustomCodingKeys(stringValue: $0.key) {
                try? encodingContainer.encode($0.value, forKey: customCodingKey)
            }
        }
    }
    
    public init(values: [String: Double]) {
        self.values = values
    }
}
