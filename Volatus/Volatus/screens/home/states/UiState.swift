//
//  UiState.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import Foundation
import SwiftUI
struct UiState {
   
    let backImage : String = "background"
    let swapIcon : ImageSystem = swapSystemImage
    let searchButtonTitle : String = TextTheme.search.rawValue
    
    let oneWayTitle:String =  TextTheme.oneWay.rawValue
    let roundedTitle:String = TextTheme.roundedTitle.rawValue
    
    let departureTitle:String = TextTheme.departure.rawValue
    let returnTitle:String = TextTheme.returnTitle.rawValue
    
    let fromTitle : String = TextTheme.fromTitle.rawValue
    let toTitle : String = TextTheme.toTitle.rawValue
    let passenger : String = TextTheme.passenger.rawValue
    
    var passengerText:String = ""
    var returnVisible:Bool = true
}
