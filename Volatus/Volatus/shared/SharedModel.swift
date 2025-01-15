//
//  SharedModel.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import Foundation
import SwiftUI
class SharedModel : ObservableObject {
    var fromAirport : Airport? = nil
    var toAirport:Airport? = nil
    @Published var fromText : String = TextTheme.choosen.rawValue
    @Published var toText: String = TextTheme.choosen.rawValue
    @Published var airportState :Bool = true
    
    var departureDate:Date = Date.now
    var returnDate:Date? = nil
    
    @Published    var depatureDateTxet:String = Date.now.covertDate(formatterType: .typeOne)
    @Published   var returnDateText:String = ""
    
    var departureTicket:Ticket?
    var retrunTicket:Ticket?

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
    
    @Published var passengerText = "1 Adult"
    
    //MARK: updateLocation
    func updateLocation(selectedType:SelectedType,airport:Airport) {
        switch selectedType {
        case .from:
            fromAirport = airport
            fromText = "\(airport.code) - \(airport.airname)"
        case .to:
            toAirport = airport
            toText = "\(airport.code) - \(airport.airname)"
        }
        
        airportState = (fromAirport == nil || toAirport == nil) || (fromAirport?.id == toAirport?.id)
    }
    //MARK: swapAction
    func swapAction() {
        let tempLocation =  fromAirport
        fromAirport = toAirport
        toAirport = tempLocation
        
        guard let fromAirport = fromAirport else {return}
        fromText = "\(fromAirport.code) - \(fromAirport.airname)"
        
        guard let toAirport = toAirport else {return}
        toText = "\(toAirport.code) - \(toAirport.airname)"
    }
    
    //MARK: updateDate
    func updateDate(selectedType:SelectedType,date:Date?) {
        guard let date = date else {return}
        if selectedType == .from {
            departureDate = date
        }else{
           returnDate = date
        }
        
        depatureDateTxet = departureDate.covertDate(formatterType: .typeOne)
        if returnDate != nil{
            returnDateText = returnDate!.covertDate(formatterType: .typeOne)
            if returnDate! < departureDate {
                returnDateText = departureDate.covertDate(formatterType: .typeOne)
                returnDate = departureDate
            }
        }else{
            returnDateText = departureDate.covertDate(formatterType: .typeOne)
        }
    }
    
    //MARK: updatePassenger
    func updatePassenger(list:[PassengerValue]) {
        passengerList = list
        
        let list =  passengerList.map { $0.count != 0 ? "\($0.count) \($0.title)" : "" }
        let text = list.filter { !$0.isEmpty }.joined(separator: ",")
        passengerText = text
    }
    
    //MARK: updateTicketId
    func updateTicketId(type:Bool,ticket:Ticket){
        if type {
            departureTicket = ticket
        }else{
            retrunTicket = ticket
        }
    }
}
