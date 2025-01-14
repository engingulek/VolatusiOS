//
//  ReturnTicketListView.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import SwiftUI

struct ReturnTicketListView<ViewModel:ReturnTicketListViewModelProtocol>: View {
    @StateObject var viewModel:ViewModel
    @EnvironmentObject var sharedModel : SharedModel
    @State private  var navigation: Bool = false
    var body: some View {
        VStack {
            TicketInfoComponent(
                title: TextTheme.yourDepartureTicketInfo.rawValue,
                ticket: sharedModel.departureTicket
            )
            DayListComponent(list: viewModel.dateAndPrice) { id in
                viewModel.onAction(action: .onTappedDate(id: id))
                sharedModel.updateDate(selectedType: .to, date: viewModel.updatedReturnDate)
            }
            Spacer()
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.ticketList, id: \.id) { ticket in
                        TicketComponent(ticket: ticket) {
                            sharedModel.updateTicketId(type: false, ticket: ticket)
                            navigation = true
                        }
                    }
                }
            }
            
          
        }.navigationTitle(TextTheme.returnTicketList.rawValue)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(Color.gray.opacity(0.1))
                .navigationDestination(isPresented: $navigation, destination: {
                    PassengerInfoScreen(viewModel: PassengerInfoViewModel()).environmentObject(sharedModel)
                })
                .onAppear{
                    viewModel.onAppear(
                        departureAirport:sharedModel.toAirport,
                        arrivalAirport: sharedModel.fromAirport,
                        departureDate: sharedModel.departureDate,
                        returnDate: sharedModel.returnDate ?? sharedModel.departureDate)
                }
    }
}

#Preview {
    ReturnTicketListView(viewModel: ReturnTicketListViewModel(service: ReturnTicketListService()))
}
