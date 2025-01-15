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
    var selectedStateColor:String
    
}

protocol DepartureTicketListViewModelProtocol : ObservableObject {
    var dateAndPrice : [DayAndPrice] {get}
    var updatedDepartureDate:Date  {get}
    var updatedReturnDate: Date? {get}
    var ticketList:[Ticket] {get}
    var messageState : (message:String,state:Bool) {get}
    
    func onAppear(departureAirport:Airport?,arrivalAirport:Airport?,depatureDate:Date,returnDate:Date?)
    func onAction(action:DepartureTicketListActions)
    
    
}


final class DepartureTicketListViewModel : DepartureTicketListViewModelProtocol {
    @Published var dateAndPrice: [DayAndPrice] = []
    @Published var ticketList:[Ticket] = []
    @Published var messageState : (message:String,state:Bool) = (message:TextTheme.defaultEmpty.rawValue,state:false)
    private var oldSelectedIndex:Int?
    var updatedDepartureDate:Date = Date.now
    var updatedReturnDate: Date?
    private var tempList:[DayAndPrice]  = []
    private var service:DepartureTicketListServiceProtocol
    private var selecteddepartureAirport:Airport?
    private var selectedarrivalAirport:Airport?
    
    
    init( service: DepartureTicketListServiceProtocol) {
        
        self.service = service
    }
    
    
    func onAppear(departureAirport:Airport?,arrivalAirport:Airport?,
                  depatureDate:Date,returnDate:Date?) {
      
        selecteddepartureAirport = departureAirport
        selectedarrivalAirport = arrivalAirport
        createDatePrice(getDate: depatureDate)
        updatedReturnDate = returnDate
        
        Task{
          await  getTicketList(date: depatureDate.covertDate(formatterType: .typeFour))
        }
      
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
        
        let selectedDefautlDate = getDate.covertDate(formatterType: .typeFour)
        for offset in 0..<30 {
            if let dayDate = calendar.date(byAdding: .day, value: offset, to: Date.now) {
                let dateValue = dayDate.covertDate(formatterType: .typeFour)
                
                let dayAndPrice = DayAndPrice(
                    id: offset,
                    date: dayDate,
                    selectedStateColor: selectedDefautlDate == dateValue 
                    ? ColorTheme.red.rawValue
                    : ColorTheme.gray.rawValue
                )
                
                dateAndPrice.append(dayAndPrice)
                tempList.append(dayAndPrice)
            }
        }
        oldSelectedIndex = dateAndPrice.filter { 
            $0.date.covertDate(formatterType: .typeFour
            ) == selectedDefautlDate }.first?.id
    }
    
    private func selectedDateAction(id:Int){
        guard let oldIndex = oldSelectedIndex else {return}
        dateAndPrice[oldIndex].selectedStateColor = ColorTheme.gray.rawValue
        
        oldSelectedIndex = id
        dateAndPrice[id].selectedStateColor = ColorTheme.red.rawValue
        let selectedDate =  dateAndPrice[id].date
        updatedDepartureDate = selectedDate
        
        Task{
          await  getTicketList(date: selectedDate.covertDate(formatterType: .typeFour))
        }
        
        
        guard let returnDate = updatedReturnDate else {return}
        
        if(selectedDate >= returnDate) {
            updatedReturnDate = selectedDate
        }
    }
    
    private func getTicketList(date:String) async{
        
        guard let selecteddepartureAirport = selecteddepartureAirport else {
            messageState = (message:TextTheme.errorMessage.rawValue,state:true)
            return}
        guard let selectedarrivalAirport = selectedarrivalAirport else {
            messageState = (message:TextTheme.errorMessage.rawValue,state:true)
            return}
        
        do {
            let list = try await service.getTickets(
                departureId: selecteddepartureAirport.id,
                arrivalId: selectedarrivalAirport.id,
                date: date.converDateForApi())
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                ticketList = list
                if list.isEmpty {
                    messageState = (message:TextTheme.noTicket.rawValue,state:true)
                }else{
                    messageState = (message:TextTheme.defaultEmpty.rawValue,state:false)
                }
             
                
            }
        }catch{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                ticketList = []
                messageState = (message:TextTheme.errorMessage.rawValue,state:true)
            }
        }
    }
}
