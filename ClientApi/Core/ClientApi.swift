//
//  ClientApi.swift
//  ClientApi
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

internal class ClientApi {
    
    // MARK: - Public methods
    
    func getData<T: Decodable>(from url: URL, completion: @escaping (_ response :T? ,_ error :Error?)->Void) {
        let getDataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, urlResponse, error) in
            guard let `self` = self else { return }
            if let error = error {
                completion(nil, error)
            }
            else if let data = data {
                do {
                    let response = try self.decode(data: data) as T
                    completion(response, nil)
                } catch (let parsingError){
                    completion(nil, parsingError)
                }
            }
        }
        getDataTask.resume()
    }
    
    // MARK: - private methods
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch {
            throw APIError.parsingFail
        }
    }
}
