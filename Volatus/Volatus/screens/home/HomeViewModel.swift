//
//  HomeViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import Foundation


enum HomeActions {
    case onTappedOneWay
    case onTappedRounded
    case onTappedSwapIcon
    
}


protocol HomeViewModelProtocol:ObservableObject {
    var uiState:UiState {get}
    var tripTypeState : TripTypeState {get}
    var dateState : DateState {get}
    var locationState:LocationState {get}
    var selectedFromLocation:Airport? {get set}
    var selectedToLocation : Airport? {get set}
    var depatureDate:Date {get set}
    var returnDate:Date? {get set}
    
    func onAction(action:HomeActions)
    func updateLocation()
    func updateDate()
    
}

final class HomeViewModel  :HomeViewModelProtocol  {

    @Published var uiState: UiState = UiState()
    @Published var tripTypeState: TripTypeState = TripTypeState()
    @Published var dateState: DateState = DateState()
    @Published var locationState: LocationState = LocationState()
    @Published var selectedFromLocation: Airport?
    @Published    var selectedToLocation: Airport?
    @Published  var depatureDate: Date = Date.now

    var returnDate: Date? = nil
    
    func onAction(action: HomeActions) {
        switch action {
        case .onTappedOneWay:
            onTappedOneWayAction()
        case .onTappedRounded:
            onTappedRoundedAction()
        case .onTappedSwapIcon:
            onTappedSwapIconAction()
            
        }
    }
    
    
    func updateLocation() {
        
        guard let fromLocation = selectedFromLocation else {return}
        locationState.fromText = "\(fromLocation.code)-\(fromLocation.name)"
        guard let toLocation = selectedToLocation else {return}
        locationState.toText = "\(toLocation.code)-\(toLocation.name)"
        
       
      
      
        
        
    }
    
    func updateDate() {
        dateState.depatureDate = depatureDate.covertDate(formatterType: .typeOne)
        if returnDate != nil {
            dateState.returnDate = returnDate!.covertDate(formatterType: .typeOne)
            if returnDate! < depatureDate {
                dateState.returnDate = depatureDate.covertDate(formatterType: .typeOne)
                returnDate = depatureDate
            }
        }else{
            dateState.returnDate = depatureDate.covertDate(formatterType: .typeOne)
        }
        
    }
    
    
    
    
}

extension HomeViewModel {
    
    private func onTappedOneWayAction(){
        tripTypeState.oneWayTripeType = TripeTypeData(
            textColor: ColorTheme.white.rawValue,
            backColor: ColorTheme.red.rawValue)
        
        tripTypeState.roundedTripeType = TripeTypeData(
            textColor: ColorTheme.red.rawValue,
            backColor: ColorTheme.white.rawValue)
        
        dateState = DateState(returnVisible: true)
        
        dateState.returnDate = ""
//        returnDate = nil
    }
    
    
    private func onTappedRoundedAction(){
        tripTypeState.oneWayTripeType = TripeTypeData(
            textColor: ColorTheme.red.rawValue,
            backColor: ColorTheme.white.rawValue)
        
        tripTypeState.roundedTripeType = TripeTypeData(
            textColor: ColorTheme.white.rawValue,
            backColor: ColorTheme.red.rawValue)
        
        dateState = DateState(returnVisible: false)
        dateState.returnDate = depatureDate.covertDate(formatterType: .typeOne)
        
        
        dateState.depatureDate = depatureDate.covertDate(formatterType: .typeOne)
        returnDate = depatureDate
    }
    
    
    
    private func onTappedSwapIconAction(){
        let tempLocation =  selectedFromLocation
        selectedFromLocation = selectedToLocation
        selectedToLocation = tempLocation
        
        
        guard let fromLocation = selectedFromLocation else {return}
        locationState.fromText = "\(fromLocation.code)-\(fromLocation.name)"
        guard let toLocation = selectedToLocation else {return}
        locationState.toText = "\(toLocation.code)-\(toLocation.name)"
    }
}
