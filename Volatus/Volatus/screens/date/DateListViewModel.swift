//
//  DateViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 30.12.2024.
//

import Foundation
enum DateValueType {
    case now
    case selected
    case disable
    case defaultDate
    case betwween

}

protocol DateListViewModelProtocol: ObservableObject {
    func onAppear(getDepartureDate:Date,getReturnDate:Date?,type:Bool)
    var weekdays: [String] { get }
    var mountCalender: [Int: String] { get }
    var dateCalender: [Int: [(type: DateValueType, dayValue: String)]] { get }
    func selectDate(index:Int, dayValue:String) -> Date
}

final class DateListViewModel: DateListViewModelProtocol {
   
    @Published var dateCalender: [Int: [(type: DateValueType, dayValue: String)]] = [:]
    @Published var mountCalender: [Int: String] = [:]
    @Published var weekdays: [String] = ["Pzt", "Sal", "Çar", "Per", "Cum", "Cmt", "Pzr"]
    private var oldIndex:Int = -1
    private var oldValueIndex:Int = -1
    private var olddayValue : String = ""
    private var selected:Bool = false
    private var dates:[(index:Int,dayValue:String,dateComponents:DateComponents)] = []
    
    

    func onAppear(getDepartureDate:Date,getReturnDate:Date?,type:Bool) {
        createCalendar(getDepartureDate:getDepartureDate,
                       getReturnDate:getReturnDate,
                       control:type)
    }
    
    func selectDate(index: Int, dayValue:String)  -> Date {
        if  selected {
            
            selected = false
            dateCalender[oldIndex]?[oldValueIndex].type = DateValueType.defaultDate
            
            oldIndex = index
            
            guard let list = dateCalender[index] else {return Date.now}
            guard let valueIndex = list.firstIndex(where: { $0.dayValue == dayValue }) else {return Date.now}
            oldValueIndex = valueIndex
            dateCalender[index]?[valueIndex].type = DateValueType.selected
            olddayValue = dayValue
            selected = true
            
        }else{
            oldIndex = index
            guard let list = dateCalender[index] else {return Date.now}
            guard let valueIndex = list.firstIndex(where: { $0.dayValue == dayValue }) else {return Date.now}
            oldValueIndex = valueIndex
            dateCalender[index]?[valueIndex].type = DateValueType.selected
            olddayValue = dayValue
            selected = true
        }
       
        let selectedDateValueComponents = dates.filter { $0.index == index && $0.dayValue == dayValue }.first
       
        let selectedDate = Calendar.current.date(from: selectedDateValueComponents!.dateComponents)
        return selectedDate ?? Date.now
       

      
    }


    private func createCalendar(getDepartureDate:Date,getReturnDate:Date?,control:Bool) {
      
        mountCalender = [:]
    dateCalender  = [:]
        let calendar = Calendar.current
        let departureDate = getDepartureDate
        var depatureDateComponents = calendar.dateComponents([.day, .month, .year], from: departureDate)
        depatureDateComponents.timeZone = TimeZone(abbreviation: "UTC")
        var nowComponents = calendar.dateComponents([.day, .month, .year], from: Date.now)
        nowComponents.timeZone = TimeZone(abbreviation: "UTC")
       
        for i in 0...3 {
            if let dateWithAddedMonths = calendar.date(byAdding: .month, value: i, to: Date.now) {
                var components = calendar.dateComponents([.month, .year], from: dateWithAddedMonths)
                components.timeZone = TimeZone(abbreviation: "UTC")
                if let month = components.month, let year = components.year {
                    mountCalender[i] = dateWithAddedMonths.covertDate(formatterType: .typeTwo)

                    if dateCalender[i] == nil {
                        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
                        let weekday = calendar.component(.weekday, from: firstDayOfMonth)
                        let offset = (weekday - 2 + 7) % 7
                        dateCalender[i] = Array(repeating: (type: .defaultDate, dayValue: ""), count: offset)
                    }

                    let range = calendar.range(of: .day, in: .month, for: dateWithAddedMonths)!
                    
                    for day in range {
                        var dateComponents = DateComponents()
                        dateComponents.day = day
                        dateComponents.month = month
                        dateComponents.year = year
                        dateComponents.timeZone = TimeZone(abbreviation: "UTC")
                        dates.append((index: i, dayValue: "\(day)", dateComponents: dateComponents))
                        
                        let dateRange = Calendar.current.date(from: dateComponents)!
                        let nowDate = Calendar.current.date(from: nowComponents)!
                        
                        let type: DateValueType

                        if dateRange == nowDate {
                            type = .now
                        } else if (control && nowDate > dateRange) || (!control && departureDate > dateRange) {
                            type = .disable
                        } else if dateRange == departureDate || dateRange == getReturnDate {
                            type = .selected
                        } else if departureDate < dateRange && dateRange < (getReturnDate ?? departureDate) {
                            type = .betwween
                        } else {
                            type = .defaultDate
                        }
                        dateCalender[i]?.append((type: type, dayValue: "\(day)"))
                    
                        
    
                    }
                }
            }
        }
    }
}
