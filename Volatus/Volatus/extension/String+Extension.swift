//
//  String+Extension.swift
//  Volatus
//
//  Created by Engin Gülek on 30.12.2024.
//

import Foundation


extension String{
    func convertToDate(formatterType:DateFormatterType) -> Date {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatterType.rawValue
       dateFormatter.locale = Locale(identifier: "en_US")
        let date = dateFormatter.date(from: self) ?? Date.now
        return date
    }
}
