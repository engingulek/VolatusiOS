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
    var ticketList:[Ticket] {get}
    var messageState : (message:String,state:Bool) {get}
    func onAppear(departureAirport:Airport?,arrivalAirport:Airport?,departureDate:Date,returnDate:Date)
    func onAction(action:ReturnTicketListActions)
}


final class ReturnTicketListViewModel : ReturnTicketListViewModelProtocol {
    
    @Published var dateAndPrice: [DayAndPrice] = []
    @Published var ticketList:[Ticket] = []
    @Published var messageState : (message:String,state:Bool) = (message:TextTheme.defaultEmpty.rawValue,state:false)
    private var oldSelectedIndex:Int?
    var updatedReturnDate: Date?
    private var service:ReturnTicketListServiceProtocol
    private var selecteddepartureAirport:Airport?
    private var selectedarrivalAirport:Airport?
    
    
    init(service: ReturnTicketListServiceProtocol) {
        self.service = service
    }
    
    func onAppear(departureAirport:Airport?,arrivalAirport:Airport?,departureDate: Date,returnDate:Date) {
        
        selecteddepartureAirport = departureAirport
        selectedarrivalAirport = arrivalAirport
        createDatePrice(departureDate: departureDate, returnDate: returnDate)
        
        Task{
          await  getTicketList(date: returnDate.covertDate(formatterType: .typeFour))
        }

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
