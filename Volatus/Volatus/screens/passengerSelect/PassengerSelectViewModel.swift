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
    func onAppear(passengerValue:[PassengerValue])
}

final class PassengerSelectViewModel : PassengerSelectViewModelProtocol {
    
    @Published var passengerSelectState: PassengerSelectState = PassengerSelectState()
    
    func onAppear(passengerValue:[PassengerValue]) {
        passengerSelectState.passengerList = passengerValue
        
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
