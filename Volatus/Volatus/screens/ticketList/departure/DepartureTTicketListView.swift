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
    
    var body: some View {
        VStack{
            
           
            DayListComponent(
                list: viewModel.dateAndPrice){ id in
                    viewModel.onAction(action: .onTappedDate(id: id))
                    
                    sharedModel.updateDate(type: true, date: viewModel.updatedDepartureDate)
                    sharedModel.updateDate(type: false, date: viewModel.updatedReturnDate)
                 
                   // viewModel.onAction(action: .onTappedDate(id: id))
               // sharedModel.updateDate(type: true, date: result.depatureDate)
                   
                  //  sharedModel.updateDate(type: false, date: viewModel.updatedReturnDate)
                }.environmentObject(sharedModel)
            Spacer()
            Text("\(viewModel.dateAndPrice.count)")
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(1...20, id: \.self) { index in
                        NavigationLink {
                            PassengerInfoScreen().environmentObject(sharedModel)
                        } label: {
                            TicketComponent()
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
            }
            
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Departure Ticket List")
            .onAppear{
                viewModel.onAppear(depatureDate: sharedModel.departureDate, returnDate: sharedModel.returnDate)
            }
          
    }
}

#Preview {
    DepartureTicketListView(viewModel: DepartureTicketListViewModel())
}
