//
//  AirportListViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 29.12.2024.
//

import Foundation

enum AirportListViewActions {
    case onChangeSearchText(String)
}


protocol AirportListViewModelProtocol:ObservableObject {
    var airportList:[Airport] {get}
    var uiState : AirportUiState {get}
    
    func onAppear()
    func onActions(action:AirportListViewActions)
}

final class AirportListViewModel : AirportListViewModelProtocol {
   
    @Published var airportList: [Airport] = []
    @Published var uiState: AirportUiState = AirportUiState()
    private var tempAirportList : [Airport] = []
    
    func onAppear() {
        airportList = [
            .init(id: 1, name: "Los Angeles International Airport", code: "LAX", city: "Los Angeles", country: "United States"),
            .init(id: 2, name: "London Heathrow Airport", code: "LHR", city: "London", country: "United Kingdom"),
            .init(id: 3, name: "Tokyo Haneda Airport", code: "HND", city: "Tokyo", country: "Japan"),
            .init(id: 4, name: "Dubai International Airport", code: "DXB", city: "Dubai", country: "United Arab Emirates"),
            .init(id: 5, name: "Istanbul Airport", code: "IST", city: "Istanbul", country: "Turkey")
            
        ]
        tempAirportList = airportList
    }
    
    func onActions(action: AirportListViewActions) {
        switch action {
        case .onChangeSearchText(let text):
            onChangeSearchTextAction(text: text)
        }
    }
}


extension AirportListViewModel {
    private func onChangeSearchTextAction(text: String) {
     
         if text.isEmpty {
             airportList = tempAirportList
             uiState.listState = (message:TextTheme.defaultEmpty.rawValue,false)
         }else{
             airportList = tempAirportList.filter{ $0.name.lowercased().contains(text.lowercased())}
             if airportList.isEmpty {
                 uiState.listState = (message:TextTheme.notFoundAirport.rawValue,true)
             }else {
                 uiState.listState = (message:TextTheme.defaultEmpty.rawValue,false)
             }
           
         }
     }
}
