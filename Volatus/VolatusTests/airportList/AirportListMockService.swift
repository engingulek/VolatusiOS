//
//  AirportListMockService.swift
//  VolatusTests
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation
@testable import Volatus
enum MockError: Error {
    case mockError
}

final class AirportListMockService : AirportListServiceProtocol {
    var airportList : [Airport] = []
    var mockErrorAirportList : Bool = false
    func getAllAirportList() async throws -> [Volatus.Airport] {
        if mockErrorAirportList {
            throw MockError.mockError
        }else{
            return airportList
        }
    }
    
    
}



