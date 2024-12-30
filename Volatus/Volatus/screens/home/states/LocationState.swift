//
//  LocationState.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import Foundation

struct LocationState {
    var fromText : String = TextTheme.choosen.rawValue
    var toText: String = TextTheme.choosen.rawValue
    var searchType:SearchType = .forFrom
    
    
}
