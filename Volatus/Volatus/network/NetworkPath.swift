//
//  NetworkPath.swift
//  Volatus
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation
import Alamofire

enum NetworkPath {
    case getAllAirport
    
}


extension NetworkPath : TargetType {
    var baseURL: String {
        return Constants.baseUrl.rawValue
    }
    
    var path: String {
        switch self {
        case .getAllAirport:
            return Constants.airport.rawValue + Constants.getAll.rawValue
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var requestType: RequestType {
        switch self {
        default:
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
    
}
