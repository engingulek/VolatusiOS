//
//  DepartureTicketListService.swift
//  Volatus
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation

protocol DepartureTicketListServiceProtocol {
    func getTickets(departureId:Int,arrivalId:Int,date:String) async throws -> [Ticket]
}


class DepartureTicketListService : DepartureTicketListServiceProtocol {
    private let networkManager:NetworkManagerProtocol = NetworkManager()
    func getTickets(departureId: Int, arrivalId: Int, date: String) async throws -> [Ticket] {
        do{
            let response = try await networkManager.fetch(target: .getTickets(departureId, arrivalId, date), responseClass: [Ticket].self)
            return response
        }catch{
            throw error
        }
    }
    
    
}
