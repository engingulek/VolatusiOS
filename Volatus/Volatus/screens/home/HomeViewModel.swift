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
    
    
    
}


protocol HomeViewModelProtocol:ObservableObject {
    var uiState:UiState {get}
    var tripTypeState : TripTypeState {get}
    var dateState : DateState {get}
    var locationState:LocationState {get}

  //  var depatureDate:Date {get set}
  //  var returnDate:Date? {get set}
   // var passengerList:[PassengerValue] {get set}
   
    
 
    func onAction(action:HomeActions)
    
   // func updateDate()
    func updatePassengerValue()
  
  
    
}

final class HomeViewModel  :HomeViewModelProtocol  {
  
    
    @Published var uiState: UiState = UiState()
    @Published var tripTypeState: TripTypeState = TripTypeState()
    @Published var dateState: DateState = DateState()
    @Published var locationState: LocationState = LocationState()

    
    var depatureDate: Date = Date.now
    var returnDate: Date? = nil
    
    
    var passengerList: [PassengerValue] = [
        .init(title: TextTheme.adultTitle.rawValue,
              ageSpaceTitle: TextTheme.adultRangeTitle.rawValue,
              count: 1, minusButtonStatus: true),
        .init(title: TextTheme.child.rawValue,
              ageSpaceTitle: TextTheme.childRangeTitle.rawValue,
              count: 0, minusButtonStatus: true),
        .init(title: TextTheme.babyTitle.rawValue,
              ageSpaceTitle: TextTheme.babyRangeTitle.rawValue,
              count: 0, minusButtonStatus: true)
    
    ]
    
    

    
    func onAction(action: HomeActions) {
        switch action {
        case .onTappedOneWay:
            onTappedOneWayAction()
        case .onTappedRounded:
            onTappedRoundedAction()
      
        }
    }
    
    
  
    /*func updateDate() {
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
        
    }*/
    
    func updatePassengerValue() {
      
      let list =  passengerList.map { $0.count != 0 ? "\($0.count) \($0.title)" : "" }
        let text = list.filter { !$0.isEmpty }.joined(separator: ",")
        uiState.passengerText = text
        
        
        
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
    
    
    
 

    
}
