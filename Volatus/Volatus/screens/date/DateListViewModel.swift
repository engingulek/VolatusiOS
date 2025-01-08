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
    var uiState : DateUiState {get}
    
    func onAppear(getDepartureDate:Date,getReturnDate:Date?,selectedType:SelectedType)
 
    func selectDate(index:Int, dayValue:String) -> Date
    
    func title(type:SelectedType) -> String
}

final class DateListViewModel: DateListViewModelProtocol {
   
    @Published var uiState: DateUiState = DateUiState()

    private var oldIndex:Int = -1
    private var oldValueIndex:Int = -1
    private var olddayValue : String = ""
    private var selected:Bool = false
    private var dates:[(index:Int,dayValue:String,dateComponents:DateComponents)] = []
    
    

    func onAppear(getDepartureDate:Date,getReturnDate:Date?,selectedType:SelectedType) {
        createCalendar(getDepartureDate:getDepartureDate,
                       getReturnDate:getReturnDate,
                       selectedType:selectedType)
    }
    
    func title(type: SelectedType) -> String {
        switch type {
        case .from:
            return TextTheme.dateDeparture.rawValue
        case .to:
            return TextTheme.dateReturn.rawValue
        }
    }
    
    func selectDate(index: Int, dayValue:String)  -> Date {
        if  selected {
            
            selected = false
           uiState.dateCalender[oldIndex]?[oldValueIndex].type = DateValueType.defaultDate
            
            oldIndex = index
            
            guard let list = uiState.dateCalender[index] else {return Date.now}
            guard let valueIndex = list.firstIndex(where: { $0.dayValue == dayValue }) else {return Date.now}
            oldValueIndex = valueIndex
            uiState.dateCalender[index]?[valueIndex].type = DateValueType.selected
            olddayValue = dayValue
            selected = true
            
        }else{
            oldIndex = index
            guard let list = uiState.dateCalender[index] else {return Date.now}
            guard let valueIndex = list.firstIndex(where: { $0.dayValue == dayValue }) else {return Date.now}
            oldValueIndex = valueIndex
            uiState.dateCalender[index]?[valueIndex].type = DateValueType.selected
            olddayValue = dayValue
            selected = true
        }
       
        let selectedDateValueComponents = dates.filter { $0.index == index && $0.dayValue == dayValue }.first
       
        let selectedDate = Calendar.current.date(from: selectedDateValueComponents!.dateComponents)
        return selectedDate ?? Date.now
       

      
    }


    private func createCalendar(getDepartureDate:Date,getReturnDate:Date?,selectedType:SelectedType) {
      
        uiState.mountCalender = [:]
        uiState.dateCalender  = [:]
        let calendar = Calendar.current
        let departureDate = getDepartureDate
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date.now)
       
       
        for i in 0...3 {
            if let dateWithAddedMonths = calendar.date(byAdding: .month, value: i, to: Date.now) {
                let components = calendar.dateComponents([.month, .year], from: dateWithAddedMonths)
                if let month = components.month, let year = components.year {
                    uiState.mountCalender[i] = dateWithAddedMonths.covertDate(formatterType: .typeTwo)

                    if uiState.dateCalender[i] == nil {
                        let firstDayOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
                        let weekday = calendar.component(.weekday, from: firstDayOfMonth)
                        let offset = (weekday - 2 + 7) % 7
                        uiState.dateCalender[i] = Array(repeating: (type: .defaultDate, dayValue: ""), count: offset)
                    }

                    let range = calendar.range(of: .day, in: .month, for: dateWithAddedMonths)!
                    
                    for day in range {
                        var dateComponents = DateComponents()
                        dateComponents.day = day
                        dateComponents.month = month
                        dateComponents.year = year
                        dates.append((index: i, dayValue: "\(day)", dateComponents: dateComponents))
                        
                        let dateRange = Calendar.current.date(from: dateComponents)!
                        let nowDate = Calendar.current.date(from: nowComponents)!
                        
                        let type: DateValueType

                        if dateRange == nowDate {
                            type = .now
                        } else if (selectedType == .from && nowDate > dateRange) || (selectedType == .to && departureDate > dateRange) {
                            type = .disable
                        } else if dateRange == departureDate || dateRange == getReturnDate {
                            type = .selected
                        } else if departureDate < dateRange && dateRange < (getReturnDate ?? departureDate) {
                            type = .betwween
                        } else {
                            type = .defaultDate
                        }
                        uiState.dateCalender[i]?.append((type: type, dayValue: "\(day)"))
                    }
                }
            }
        }
    }
}
