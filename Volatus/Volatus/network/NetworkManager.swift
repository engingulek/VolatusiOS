//
//  NetworkManager.swift
//  Volatus
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation
import Alamofire

enum NetworkError : Error {
    case invalidResponse
    case valueError
    case badRequest
    case notFound
    case unexpectedError
}

protocol NetworkManagerProtocol {
  func fetch<T:Decodable>(
       target:NetworkPath,
       responseClass:T.Type) async throws -> T
}

class NetworkManager : NetworkManagerProtocol {
   public init() {}
   /// Fetch for NetworkManager
   /// - Parameters:
   ///   - target: request types
   ///   - responseClass: The type of data that will be received in response to the request
   func fetch<T>(target: NetworkPath, responseClass: T.Type) async throws -> T where T : Decodable {
       let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
       let url = target.baseURL + target.path
       let parameters = buildParams(requestType: target.requestType)
       let request = AF.request(
           url,
           method: method,
           parameters: parameters.0,
           encoding: parameters.1
       )
           .validate()
           .serializingDecodable(T.self)
       
       print(url)
       let result = await request.response
       
       guard let response = result.response else {
           throw NetworkError.invalidResponse
       }
       
       switch response.statusCode {
       case 200...299:
           guard let value = result.value else {
               throw NetworkError.valueError
           }
           return value
       case 400:
           throw NetworkError.badRequest
       case 404:
           throw NetworkError.notFound
       default:
           throw NetworkError.unexpectedError
       }
   }
   
   private func buildParams(requestType: RequestType) -> ([String: Any], ParameterEncoding) {
       switch requestType {
       default:
           return ([:], URLEncoding.default)
           
       }
   }
}
