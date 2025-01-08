//
//  TicketListView.swift
//  Volatus
//
//  Created by Engin Gülek on 2.01.2025.
//

import SwiftUI

struct DepartureTicketListView<ViewModel:DepartureTicketListViewModelProtocol>: View {
    @EnvironmentObject var sharedModel : SharedModel
    @StateObject  var viewModel:ViewModel
    @State private  var navigation: Bool = false
    
    var body: some View {
        VStack(alignment:.leading){
            DayListComponent(
                list: viewModel.dateAndPrice){ id in
                    viewModel.onAction(action: .onTappedDate(id: id))
                    sharedModel.updateDate(selectedType: .from, date: viewModel.updatedDepartureDate)
                    sharedModel.updateDate(selectedType: .to, date: viewModel.updatedReturnDate)
           
                }
            Spacer()
            
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(1...20, id: \.self) { index in
                        TicketComponent(){
                            sharedModel.updateTicketId(type: true, ticketId: index)
                            navigation = true
                        }
                    }
                }
            }
            
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
            .navigationTitle(TextTheme.departureTicketList.rawValue)
            .navigationDestination(isPresented: $navigation, destination: {
                sharedModel.returnDate == nil ?
                AnyView(  PassengerInfoScreen(viewModel:PassengerInfoViewModel()).environmentObject(sharedModel)) :
                AnyView(ReturnTicketListView(viewModel: ReturnTicketListViewModel()).environmentObject(sharedModel)
                )
            })
            .onAppear{
                viewModel.onAppear(depatureDate: sharedModel.departureDate, returnDate: sharedModel.returnDate)
            }
    }
}

#Preview {
    DepartureTicketListView(viewModel: DepartureTicketListViewModel())
}
