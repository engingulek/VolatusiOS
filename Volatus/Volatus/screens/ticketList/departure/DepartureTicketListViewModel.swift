//
//  TicketListViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import Foundation

enum DepartureTicketListActions{
    case onTappedDate(id:Int)

}
struct DayAndPrice {
    let id:Int
    let date:Date
    let price:Int
    var selectedStateColor:String
    
}



protocol DepartureTicketListViewModelProtocol : ObservableObject {
    var dateAndPrice : [DayAndPrice] {get}
    var updatedDepartureDate:Date  {get}
        var updatedReturnDate: Date? {get}
  
    func onAppear(depatureDate:Date,returnDate:Date?)
    
    
  
    func onAction(action:DepartureTicketListActions)
  
}


final class DepartureTicketListViewModel : DepartureTicketListViewModelProtocol {
   @Published var dateAndPrice: [DayAndPrice] = []
    
    private var oldSelectedIndex:Int?
   var updatedDepartureDate:Date = Date.now
   var updatedReturnDate: Date?
    private var tempList:[DayAndPrice]  = []
    
    
    func onAppear(depatureDate:Date,returnDate:Date?) {
        createDatePrice(getDate: depatureDate)
        updatedReturnDate = returnDate
    }
    
    
    func onAction(action: DepartureTicketListActions) {
        switch action {
        case .onTappedDate(let id):
            selectedDateAction(id: id)
      
        }
    }
}



extension DepartureTicketListViewModel {
   
    private func createDatePrice(getDate:Date){
        dateAndPrice = []
        let calendar = Calendar.current
         let formatter = DateFormatter()
         formatter.dateFormat = "E d MMM"
        let selectedDefautlDate = formatter.string(from: getDate)
         for offset in 0..<30 {
             if let dayDate = calendar.date(byAdding: .day, value: offset, to: Date.now) {
                 let dateValue = formatter.string(from: dayDate)
               
                 let dayAndPrice = DayAndPrice(
                    id: offset,
                    date: dayDate,
                    price: 1500,
                    selectedStateColor: selectedDefautlDate == dateValue ? ColorTheme.red.rawValue : ColorTheme.gray.rawValue
                 )
             
                 dateAndPrice.append(dayAndPrice)
                 tempList.append(dayAndPrice)
                 
             }
         }
        oldSelectedIndex = dateAndPrice.filter { $0.date.covertDate(formatterType: .typeFour) == selectedDefautlDate }.first?.id
    }
    
    private func selectedDateAction(id:Int){
        guard let oldIndex = oldSelectedIndex else {return}
        dateAndPrice[oldIndex].selectedStateColor = ColorTheme.gray.rawValue
        
        oldSelectedIndex = id
        dateAndPrice[id].selectedStateColor = ColorTheme.red.rawValue
        let selectedDate =  dateAndPrice[id].date
        updatedDepartureDate = selectedDate
        guard let returnDate = updatedReturnDate else {return}
        
        if(selectedDate >= returnDate) {
            updatedReturnDate = selectedDate
        }
    }
}
