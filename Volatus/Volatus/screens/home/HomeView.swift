//
//  HomeView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct HomeView<ViewModel:HomeViewModelProtocol>: View {
    @StateObject  var viewModel:ViewModel
    @State var selectedDepatureDate : Date = .now
    @EnvironmentObject var sharedModel : SharedModel
    
 
    var body: some View {
        ZStack{
            VStack{
                Image(viewModel.uiState.backImage)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                Spacer()
            }
            
            VStack(spacing:15){
                HStack{
                    
                    TripButton(
                        title: viewModel.uiState.oneWayTitle,
                        tripStateData: viewModel.tripTypeState.oneWayTripeType,
                        action: {viewModel.onAction(action: .onTappedOneWay)})
                    
                    
                    TripButton(
                        title: viewModel.uiState.roundedTitle,
                        tripStateData: viewModel.tripTypeState.roundedTripeType,
                        action: {viewModel.onAction(action: .onTappedRounded)})
                    
                }
                
                
                
                NavigationLink {
                    AirportList(viewModel: AirportListViewModel(),
                                searchType: .forFrom).environmentObject(sharedModel)
                } label: {
                    LocationView(
                        title: viewModel.uiState.fromTitle,
                        locationTitle: sharedModel.fromText)
                }
                
                Button {
                    sharedModel.swapAction()
                } label: {
                    Image(systemName: viewModel.uiState.swapIcon)
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                }
                
                
                
                NavigationLink {
                    AirportList(viewModel: AirportListViewModel(),
                                searchType: .forTo).environmentObject(sharedModel)
                } label: {
                    LocationView(
                        title: viewModel.uiState.toTitle,
                        locationTitle: sharedModel.toText)
                }
                HStack{
                  
                   NavigationLink {
                       DateListView(viewModel: DateListViewModel(),
                                     type: true).environmentObject(sharedModel)
                    } label: {
                    DateView(title: viewModel.uiState.departureTitle,
                             date: sharedModel.depatureDateTxet)
                    }
                    
                    NavigationLink {
                        DateListView(viewModel: DateListViewModel(),
                                    type: false).environmentObject(sharedModel)
                    } label: {
                        !viewModel.dateState.returnVisible || sharedModel.returnDate != nil ?
                    DateView(title: viewModel.uiState.returnTitle,
                             date: sharedModel.returnDateText) : nil
                    }
                    
                }
                NavigationLink {
                    PassengerSelectView(viewModel: PassengerSelectViewModel())
                    .environmentObject(sharedModel)
                } label: {
                    PassengerView(title: viewModel.uiState.passenger,
                                  passenger:sharedModel.passengerText)
                }
                
                NavigationLink {
                    DepartureTicketListView(
                        viewModel: DepartureTicketListViewModel()
                    ).environmentObject(sharedModel)
                    
                } label: {
                    Text(viewModel.uiState.searchButtonTitle)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth:.infinity)
                        .frame(height:40)
                        .background(Color(hex: ColorTheme.red.rawValue))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .disabled(sharedModel.fromAirport == nil && sharedModel.toAirport == nil)
              
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            
            .padding(.horizontal, 20)
            
        }.ignoresSafeArea()
          
        
    }
}




#Preview {
    HomeView(viewModel: HomeViewModel())
}
