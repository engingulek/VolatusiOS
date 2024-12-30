//
//  DateState.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import Foundation

struct DateState {
   
    var returnVisible:Bool = true
    var depatureDate:String = Date.now.covertDate(formatterType: .typeOne)
    var returnDate:String = ""
}
