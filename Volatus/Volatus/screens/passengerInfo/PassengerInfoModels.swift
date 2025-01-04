//
//  Models.swift
//  Volatus
//
//  Created by Engin Gülek on 4.01.2025.
//

import Foundation

struct InfoShow {
    let id:Int
    let index:Int
    let passengerTitle:String
    var showState:Bool
}

struct PassengerInfo : Identifiable {
    var id:Int
    var trIdNumber:String
    var name:String
    var surname:String
    var birthDate:Date
    var dateRange:(start:Date,finish:Date)
}

struct PassengerInfoError : Identifiable {
    var id:Int
    var trIdNumberError:(errorMessage:String,errorState:Bool) = ("",false)
    var nameError:(errorMessage:String,errorState:Bool) = ("",false)
    var surnameError:(errorMessage:String,errorState:Bool) = ("",false)
    var birthDateError:(errorMessage:String,errorState:Bool) = ("",false)
}
