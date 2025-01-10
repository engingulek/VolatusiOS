//
//  AirportListService.swift
//  Volatus
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation

protocol AirportListServiceProtocol {
    func getAllAirportList()  async throws -> [Airport]
}

class AirportListService : AirportListServiceProtocol {
    private let networkManager:NetworkManagerProtocol = NetworkManager()
    func getAllAirportList() async throws -> [Airport] {
        do{
            let response  = try await networkManager.fetch(target: .getAllAirport, responseClass: [Airport].self)
            return response
        }catch{
            throw error
        }
    }
    
    
}
