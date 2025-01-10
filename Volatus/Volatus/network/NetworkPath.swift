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
    case getTickets(Int,Int,String)
    
}


extension NetworkPath : TargetType {
    var baseURL: String {
        return Constants.baseUrl.rawValue
    }
    
    var path: String {
        switch self {
        case .getAllAirport:
            return Constants.airport.rawValue + Constants.getAll.rawValue
        case .getTickets(let departureId, let arrivalId, let date):
            return Constants.ticket.rawValue
            + Constants.getTickets.rawValue
            + "?" + "departureAirportId=\(departureId)&arrivalAirportId=\(arrivalId)&date=\(date)"
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
