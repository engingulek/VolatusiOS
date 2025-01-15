//
//  AirportUiState.swift
//  Volatus
//
//  Created by Engin Gülek on 29.12.2024.
//

import Foundation


struct AirportUiState {
    let searchPlaceholder = TextTheme.searchPlaceholder.rawValue
    var listState:(message:String,state:Bool) = (message:TextTheme.defaultEmpty.rawValue,false)

}
