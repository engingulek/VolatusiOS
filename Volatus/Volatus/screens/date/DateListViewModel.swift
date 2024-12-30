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
}

protocol DateListViewModelProtocol: ObservableObject {
    func onAppear()
    var weekdays: [String] { get }
    var mountCalender: [Int: String] { get }
    var dateCalender: [Int: [(type: DateValueType, dayValue: String)]] { get }
}

final class DateListViewModel: DateListViewModelProtocol {
    @Published var dateCalender: [Int: [(type: DateValueType, dayValue: String)]] = [:]
    @Published var mountCalender: [Int: String] = [:]
    @Published var weekdays: [String] = ["Pzt", "Sal", "Çar", "Per", "Cum", "Cmt", "Pzr"]

    func onAppear() {
        createCalendar()
    }

    private func createCalendar() {
        let calendar = Calendar.current
        let departureDate = Date()
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date.now)

        for i in 0...3 {
            if let dateWithAddedMonths = calendar.date(byAdding: .month, value: i, to: departureDate) {
                let components = calendar.dateComponents([.month, .year], from: dateWithAddedMonths)
                
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

                        if nowComponents == dateComponents {
                            dateCalender[i]?.append((type: .now, dayValue: "\(day)"))
                        } else if Date.now > calendar.date(from: dateComponents)! {
                            dateCalender[i]?.append((type: .disable, dayValue: "\(day)"))
                        } else {
                            dateCalender[i]?.append((type: .defaultDate, dayValue: "\(day)"))
                        }
                    }
                }
            }
        }
    }
}
