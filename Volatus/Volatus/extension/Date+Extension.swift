//
//  Date+Extension.swift
//  Volatus
//
//  Created by Engin Gülek on 29.12.2024.
//

import Foundation

enum DateFormatterType:String {
    /// is "MMMM dd, yyyy"
    case typeOne = "MMMM dd, yyyy"
    case typeTwo = "MMMM yyyy"
}

extension Date {
    func covertDate(formatterType:DateFormatterType) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatterType.rawValue
        return formatter.string(from: self)
    }
}


/*extension DateComponents {
    func covertDate(formatterType:DateFormatterType) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatterType.rawValue
        return formatter.string(from: self)
    }
}*/
