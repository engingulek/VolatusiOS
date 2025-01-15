//
//  PassengerInfoViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 4.01.2025.
//

import Foundation

enum PassengerInfoActions {
    case onTappedPassenger(Int)
    case controlTrId(Int)
    case controlName(Int)
    case controlSurname(Int)
    
}

protocol PassengerInfoViewModelProtocol : ObservableObject {
    var infoShowList:[InfoShow] {get}
    var passengerInfoList : [PassengerInfo] {get set}
    var passengerInfoErrorList : [PassengerInfoError] {get}
    
    func onAppear(passengerList:[PassengerValue])
    func onActions(action:PassengerInfoActions)
    
}


final class PassengerInfoViewModel : PassengerInfoViewModelProtocol {
    @Published  var passengerInfoList : [PassengerInfo] = []
    @Published var passengerInfoErrorList : [PassengerInfoError] = []
    @Published var infoShowList: [InfoShow] = []
    
    func onAppear(passengerList:[PassengerValue]) {
        
        var id:Int = 0
        for passenger in passengerList{
            for index in 0..<passenger.count {
                if(passenger.count != 0 ) {
                    let infoShow = InfoShow(
                        id: id, index: index, passengerTitle: passenger.title, showState: false)
                    infoShowList.append(infoShow)
                    let defaultBirthDate:Date
                    let startDate:Date
                    let finishDate:Date
                    let currentDate = Date()
                    if passenger.title == TextTheme.adultTitle.rawValue {
                        
                        defaultBirthDate =  currentDate.subtractYears(18)
                        startDate = currentDate.subtractYears(18)
                        finishDate = currentDate.subtractYears(80)
                    }else if passenger.title == TextTheme.child.rawValue {
                        defaultBirthDate = currentDate.subtractYears(11)
                        startDate = currentDate.subtractYears(2)
                        finishDate = currentDate.subtractYears(11)
                    }else if passenger.title == TextTheme.babyTitle.rawValue {
                        defaultBirthDate = currentDate.subtractYears(1)
                        startDate = currentDate.subtractYears(0)
                        finishDate = currentDate.subtractYears(1)
                    }else{
                        defaultBirthDate = Date.now
                        startDate = Date.now
                        finishDate = Date.now
                    }
                    
                    passengerInfoList.append(
                        PassengerInfo(
                            id: id,
                            trIdNumber: "",
                            name: "",
                            surname: "",
                            birthDate: defaultBirthDate,
                            dateRange: (start: startDate, finish: finishDate)))
                    
                    passengerInfoErrorList.append(PassengerInfoError(id: id))
                    id += 1
                    
                }
            }
        }
    }
    
    func onActions(action: PassengerInfoActions) {
        switch action {
        case .onTappedPassenger(let id):
            openPassengerInfo(id: id)
        case .controlTrId(let id):
            controlTrIdAction(id: id)
        case .controlName(let id):
            controlNameAction(id: id)
        case .controlSurname(let id):
            controlSurnaneNameAction(id: id)
            
        }
    }
}

extension PassengerInfoViewModel {
    private func openPassengerInfo(id:Int) {
        infoShowList[id].showState.toggle()
    }
    
    private func controlTrIdAction(id:Int) {
        var trId = passengerInfoList[id].trIdNumber
        
        if trId.count == 0 {
            passengerInfoErrorList[id].trIdNumberError.errorMessage = TextTheme.blankError.rawValue
            passengerInfoErrorList[id].trIdNumberError.errorState = true
        }
        if trId.count >= 11 {
            
            trId = String(trId.prefix(11))
            passengerInfoList[id].trIdNumber = trId
        }
        
        let trIdControl = trId.isValidTCNumber()
        if trIdControl {
            passengerInfoErrorList[id].trIdNumberError.errorMessage = TextTheme.defaultEmpty.rawValue
            passengerInfoErrorList[id].trIdNumberError.errorState = false
            
        }else{
            passengerInfoErrorList[id].trIdNumberError.errorMessage = TextTheme.trIdError.rawValue
            passengerInfoErrorList[id].trIdNumberError.errorState = true
        }
    }
    
    private func controlNameAction(id:Int){
        let name = passengerInfoList[id].name
        if name.count == 0 {
            passengerInfoErrorList[id].nameError.errorMessage = TextTheme.blankError.rawValue
            passengerInfoErrorList[id].nameError.errorState = true
        }
        if name.count < 2 {
            passengerInfoErrorList[id].nameError.errorMessage = TextTheme.shortError.rawValue
            passengerInfoErrorList[id].nameError.errorState = true
        }else{
            passengerInfoErrorList[id].nameError.errorMessage =  TextTheme.defaultEmpty.rawValue
            passengerInfoErrorList[id].nameError.errorState = false
        }
    }
    
    private func controlSurnaneNameAction(id:Int){
        let surname = passengerInfoList[id].surname
        if surname.count == 0 {
            passengerInfoErrorList[id].surnameError.errorMessage = TextTheme.blankError.rawValue
            passengerInfoErrorList[id].surnameError.errorState = true
        }
        if surname.count < 2 {
            passengerInfoErrorList[id].surnameError.errorMessage = TextTheme.shortError.rawValue
            passengerInfoErrorList[id].surnameError.errorState = true
        }else{
            passengerInfoErrorList[id].surnameError.errorMessage =  TextTheme.defaultEmpty.rawValue
            passengerInfoErrorList[id].surnameError.errorState = false
        }
    }
    
    
}
