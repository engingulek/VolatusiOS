//
//  ReturnTicketListService.swift
//  Volatus
//
//  Created by Engin Gülek on 14.01.2025.
//

import Foundation

protocol ReturnTicketListServiceProtocol {
    func getTickets(departureId:Int,arrivalId:Int,date:String) async throws -> [Ticket]
}

class ReturnTicketListService : ReturnTicketListServiceProtocol {
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
