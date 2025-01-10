//
//  MockDepartureTicketListService.swift
//  VolatusTests
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation
@testable import Volatus

class MockDepartureTicketListService : DepartureTicketListServiceProtocol {
   
    var ticketList : [Ticket] = []
    var mockError : Bool = false
    
    
    func getTickets(departureId: Int, arrivalId: Int, date: String) async throws -> [Volatus.Ticket] {
        if mockError {
            throw MockError.mockError
        }else{
            return ticketList
        }
    }
    
}


