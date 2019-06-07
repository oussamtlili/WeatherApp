//
//  Router.swift
//  ClientApi
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

private enum Constant {
    static let baseUrl = "http://www.infoclimat.fr/public-api/gfs/json"
    static let authenticationKey = "Bx1RRlYoUXNSfwYxA3VQeQdvVGENewgvB3tRMgpvUy4Eb1MyUzNTNVc5A35XeAQyVXgEZwoxBzcKYVAoAHIEZQdtUT1WPVE2Uj0GYwMsUHsHKVQ1DS0ILwdlUT4KYlMuBGVTNlM0Uy9XPQNjV3kEMVV5BHsKNAc6CmpQMABtBGYHZFE8Vj1RNVIiBnsDNlA2Bz1UZw1nCGQHZlFnCjJTMQQxUzJTZlM3VyYDY1dvBDVVYwRtCjMHPwpgUCgAcgQeBxdRKFZ1UXFSaAYiAy5QMQdqVGA%3D&_c=6967d2789c12b45bbec4476bc7704087"
}

internal enum Router {
    case getWheathers(longitude: Double, lattitude: Double)
    
    private func urlString() -> String {
        switch self {
        case .getWheathers(let longitude, let latitude):
            return "\(Constant.baseUrl)?_ll=\(latitude),\(longitude)&_auth=\(Constant.authenticationKey)"
        }
    }
    
    func requestUrl() throws -> URL {
        guard let url = URL(string: urlString()) else { throw APIError.invalidUrl }
        return url
    }
}
