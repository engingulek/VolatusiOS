//
//  ImageTheme.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import Foundation

enum ImageTheme : String {
    case swapeIcon = "arrow.up.arrow.down.circle.fill"
    case minus = "minus.circle.fill"
    case plus = "plus.circle.fill"
    case clock = "clock.fill"
    case airplane = "airplane"
    case airplaneDeparture = "airplane.departure"
    case airplaneArrival = "airplane.arrival"
    case downArrow = "chevron.down"
    case upArrow = "chevron.up"
    
}

struct ImageSystem {

    var name:String
    var color:String
    var size:CGFloat
}

let swapSystemImage = ImageSystem(
    name: ImageTheme.swapeIcon.rawValue,
    color: ColorTheme.red.rawValue,
    size: 30)
