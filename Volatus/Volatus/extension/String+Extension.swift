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
    
    func isValidTCNumber() -> Bool {
        guard self.count == 11 else { return false }
        guard self.first != "0" else { return false }
        guard self.allSatisfy({ $0.isNumber }) else { return false }
        
        var sumOdd = 0
        var sumEven = 0
        
        for i in 0..<9 {
            let index = self.index(self.startIndex, offsetBy: i)
            let digit = Int(String(self[index])) ?? 0
            if i % 2 == 0 {
                sumOdd += digit
            } else {
                sumEven += digit
            }
        }
        
        let tenthDigit = (sumOdd * 7 - sumEven) % 10
        let tenthIndex = self.index(self.startIndex, offsetBy: 9)
        if Int(String(self[tenthIndex])) != tenthDigit { return false }
        
        let eleventhDigit = self.prefix(10).compactMap { Int(String($0)) }.reduce(0, +) % 10
        let eleventhIndex = self.index(self.startIndex, offsetBy: 10)
        if Int(String(self[eleventhIndex])) != eleventhDigit { return false }
        
        return true
    }
    
 
    
    
    
}



extension String {
    // Tarihi 12022015 gibi bir değerden 12/02/2015 formatına dönüştür
    func formatAsDate() -> String {
        // Yalnızca rakamları al
        let filteredInput = self.filter { "0123456789".contains($0) }
        
        // İlk 8 karakteri al, fazla karakter varsa kes
        let limitedInput = String(filteredInput.prefix(8))
        
        var formattedText = ""
        
        // 8 karakter varsa, tarihi formatla
        if limitedInput.count >= 4 {
            let startIndex = limitedInput.startIndex
            let day = limitedInput[startIndex..<limitedInput.index(startIndex, offsetBy: 2)]  // Gün
            let month = limitedInput[limitedInput.index(startIndex, offsetBy: 2)..<limitedInput.index(startIndex, offsetBy: 4)]  // Ay
            let year = limitedInput[limitedInput.index(startIndex, offsetBy: 4)..<limitedInput.endIndex]  // Yıl
            
            formattedText = "\(day)/\(month)/\(year)"
        } else {
            // Eğer yeterince karakter yoksa, aynen bırak
            formattedText = limitedInput
        }
        
        return formattedText
    }
}










