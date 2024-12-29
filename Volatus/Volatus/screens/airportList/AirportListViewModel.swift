//
//  AirportListViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 29.12.2024.
//

import Foundation

protocol AirportListViewModelProtocol:ObservableObject {
    var airportList:[Airport] {get}
    func onAppear()
}

final class AirportListViewModel : AirportListViewModelProtocol {
    @Published var airportList: [Airport] = []
    
    
    
    
    func onAppear() {
        airportList = [
            .init(id: 1, name: "Los Angeles International Airport", code: "LAX", city: "Los Angeles", country: "United States"),
            .init(id: 2, name: "London Heathrow Airport", code: "LHR", city: "London", country: "United Kingdom"),
            .init(id: 3, name: "Tokyo Haneda Airport", code: "HND", city: "Tokyo", country: "Japan"),
            .init(id: 4, name: "Dubai International Airport", code: "DXB", city: "Dubai", country: "United Arab Emirates"),
            .init(id: 5, name: "Istanbul Airport", code: "IST", city: "Istanbul", country: "Turkey")
            
        ]
    }
    
    
    
    
    
    
    
}
