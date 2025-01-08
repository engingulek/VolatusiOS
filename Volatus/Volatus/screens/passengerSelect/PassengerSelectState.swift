//
//  PassengerSelectState.swift
//  Volatus
//
//  Created by Engin Gülek on 31.12.2024.
//

import Foundation



struct PassengerSelectState {
    var passengerList:[PassengerValue] = []
    var passengerTitle:String = TextTheme.passengerTitle.rawValue
    var confirmButtonTitle : String = TextTheme.confirm.rawValue
    
}



struct PassengerValue : Equatable{
    
    let title:String
    let ageSpaceTitle:String
    var count:Int
    var minusButtonStatus:Bool
}
