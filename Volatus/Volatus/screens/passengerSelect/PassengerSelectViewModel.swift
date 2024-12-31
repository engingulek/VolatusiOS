//
//  PassengerSelectViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 31.12.2024.
//

import Foundation

enum PassengerAction {
    case passengerCountMinus(index:Int)
    case passengerCountPlus(index:Int)
}


protocol PassengerSelectViewModelProtocol : ObservableObject {
    var passengerSelectState :PassengerSelectState {get}
     func onAction(action:PassengerAction)
    func opAppear()
}

final class PassengerSelectViewModel : PassengerSelectViewModelProtocol {

    
    @Published var passengerSelectState: PassengerSelectState = PassengerSelectState()

    func opAppear() {
        passengerSelectState.passengerList = [
            .init(title: TextTheme.adultTitle.rawValue,
                  ageSpaceTitle: TextTheme.adultRangeTitle.rawValue,
                  count: 1, minusButtonStatus: true),
            
                .init(title: TextTheme.child.rawValue,
                      ageSpaceTitle: TextTheme.childRangeTitle.rawValue,
                      count:0,minusButtonStatus: true),
            
            
                .init(title: TextTheme.babyTitle.rawValue,
                      ageSpaceTitle: TextTheme.babyRangeTitle.rawValue,
                      count: 0,minusButtonStatus:true),
        ]
    }
    
    
    func onAction(action: PassengerAction) {
        switch action {
        case .passengerCountMinus(let index):
            var count = passengerSelectState.passengerList[index].count
            count -= 1
            
            passengerSelectState.passengerList[index].count = 
            (passengerSelectState.passengerList[index].title == TextTheme.adultTitle.rawValue)
                ? count == 0 ? 1 : count
                : count == -1 ? 0 : count
            
            passengerSelectState.passengerList[index].minusButtonStatus =  
            (passengerSelectState.passengerList[index].title == TextTheme.adultTitle.rawValue)
            ? count != 1  ? false : true
            : count != 0  ? false : true
            
        case .passengerCountPlus(let index):
            passengerSelectState.passengerList[index].count += 1
            passengerSelectState.passengerList[index].minusButtonStatus = passengerSelectState.passengerList[index].count == 0
        }
    }
    
    
}
