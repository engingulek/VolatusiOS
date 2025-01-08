//
//  ReturnTicketListViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import Foundation

enum ReturnTicketListActions{
    case onTappedDate(id:Int)
    
}

protocol ReturnTicketListViewModelProtocol : ObservableObject {
    var dateAndPrice : [DayAndPrice] {get}
    var updatedReturnDate: Date? {get}
    func onAppear(departureDate:Date,returnDate:Date)
    func onAction(action:ReturnTicketListActions)
}


final class ReturnTicketListViewModel : ReturnTicketListViewModelProtocol {
    
    @Published var dateAndPrice: [DayAndPrice] = []
    private var oldSelectedIndex:Int?
    var updatedReturnDate: Date?
    func onAppear(departureDate: Date,returnDate:Date) {
        createDatePrice(departureDate: departureDate, returnDate: returnDate)
    }
    
    
    func onAction(action: ReturnTicketListActions) {
        switch action {
        case .onTappedDate(let id):
            selectedDateAction(id: id)
        }
    }
}

extension ReturnTicketListViewModel {
    private func createDatePrice(departureDate: Date,returnDate:Date){
        dateAndPrice = []
        let calendar = Calendar.current
        
        
        let selectedDefautlDate = returnDate.covertDate(formatterType: .typeFour)
        for offset in 0..<30 {
            if let dayDate = calendar.date(byAdding: .day, value: offset, to: departureDate) {
                let dateValue = dayDate.covertDate(formatterType: .typeFour)
                
                let dayAndPrice = DayAndPrice(
                    id: offset,
                    date: dayDate,
                    price: 1500,
                    selectedStateColor: selectedDefautlDate == dateValue
                    ? ColorTheme.red.rawValue
                    : ColorTheme.gray.rawValue
                )
                
                dateAndPrice.append(dayAndPrice)
                
            }
        }
        oldSelectedIndex = dateAndPrice.filter {
            $0.date.covertDate(formatterType: .typeFour) == selectedDefautlDate
        }.first?.id
    }
    
    private func selectedDateAction(id:Int) {
        guard let oldIndex = oldSelectedIndex else {return}
        dateAndPrice[oldIndex].selectedStateColor = ColorTheme.gray.rawValue
        oldSelectedIndex = id
        dateAndPrice[id].selectedStateColor = ColorTheme.red.rawValue
        let selectedDate =  dateAndPrice[id].date
        updatedReturnDate = selectedDate
    }
}
