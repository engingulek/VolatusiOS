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
    func task() 
}

final class AirportListViewModel : AirportListViewModelProtocol {
   
    @Published var airportList: [Airport] = []
    @Published var uiState: AirportUiState = AirportUiState()
    private var tempAirportList : [Airport] = []
    private let service: AirportListServiceProtocol
    
    init(service: AirportListServiceProtocol) {
        self.service = service
    }
    
    func onAppear() {
    
        tempAirportList = airportList
    }
    
    func onActions(action: AirportListViewActions) {
        switch action {
        case .onChangeSearchText(let text):
            onChangeSearchTextAction(text: text)
        }
    }
    
    func task()  {
        Task{
            await fetchAllAirport()
        }
      
    }
}


extension AirportListViewModel {
    private func onChangeSearchTextAction(text: String) {
        if(!uiState.listState.state) {
            if text.isEmpty {
                airportList = tempAirportList
                uiState.listState = (message:TextTheme.defaultEmpty.rawValue,false)
            }else{
                airportList = tempAirportList.filter{ $0.airname.lowercased().contains(text.lowercased())}
                if airportList.isEmpty {
                    uiState.listState = (message:TextTheme.notFoundAirport.rawValue,true)
                }else {
                    uiState.listState = (message:TextTheme.defaultEmpty.rawValue,false)
                }
              
            }
        }
        
     }
    
    
    private func fetchAllAirport() async {
        do{
            let list = try await service.getAllAirportList()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                airportList = list
                tempAirportList = list
                uiState.listState = (message:TextTheme.defaultEmpty.rawValue,false)
            }
            
         
        }catch{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                airportList = []
                tempAirportList = []
                uiState.listState = (message:TextTheme.errorMessage.rawValue,true)
            }
           
        }
        
    }
}
