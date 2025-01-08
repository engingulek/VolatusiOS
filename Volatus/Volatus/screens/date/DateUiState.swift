//
//  DateState.swift
//  Volatus
//
//  Created by Engin Gülek on 8.01.2025.
//

import Foundation
import SwiftUI


struct DateUiState {
    let weekdays: [String] =  ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var mountCalender: [Int: String] = [:]
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 7)
    var dateCalender: [Int: [(type: DateValueType, dayValue: String)]] = [:]
}
