//
//  TripState.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import Foundation


struct TripTypeState {
    var oneWayTripeType: TripeTypeData = .init(
        textColor: ColorTheme.white.rawValue,
        backColor: ColorTheme.red.rawValue)
    
    var roundedTripeType: TripeTypeData = .init(
        textColor: ColorTheme.red.rawValue,
        backColor: ColorTheme.white.rawValue)
    
}

struct TripeTypeData {
    let textColor:String
    let backColor:String
}


