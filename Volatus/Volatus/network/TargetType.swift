//
//  TargetType.swift
//  Volatus
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation
import Alamofire

protocol TargetType {
    var baseURL: String {get}
    var path: String {get}
    var method: AlamofireMethod {get}
    var requestType: RequestType {get}
    var headers: [String: String]? {get}
}

enum AlamofireMethod: String {
    case GET

}

enum RequestType {
    case requestPlain
    
}

