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
    func onAction(action:HomeActions)
    
    
}

final class HomeViewModel  :HomeViewModelProtocol  {
 
    @Published var uiState: UiState = UiState()
    @Published var tripTypeState: TripTypeState = TripTypeState()
    @Published var dateState: DateState = DateState()
    @Published var locationState: LocationState = LocationState()
    
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
    }
    
    
    private func onTappedRoundedAction(){
        tripTypeState.oneWayTripeType = TripeTypeData(
            textColor: ColorTheme.red.rawValue,
            backColor: ColorTheme.white.rawValue)
        
        tripTypeState.roundedTripeType = TripeTypeData(
            textColor: ColorTheme.white.rawValue,
            backColor: ColorTheme.red.rawValue)
        
        dateState = DateState(returnVisible: false)
    }
    
    private func onTappedSwapIconAction(){
        print("Selected Swap Icon")
    }
}