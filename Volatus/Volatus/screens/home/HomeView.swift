//
//  HomeView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct HomeView<ViewModel:HomeViewModelProtocol>: View {
    @ObservedObject private var viewModel:ViewModel
    @State var selectedDepatureDate : Date = .now
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
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
                                selectedFromLocation: $viewModel.selectedFromLocation,
                                selectedToLocation: $viewModel.selectedToLocation,
                                searchType: .forFrom)
                } label: {
                    LocationView(
                        title: viewModel.uiState.fromTitle,
                        locationTitle: viewModel.locationState.fromText)
                }
                
                Button {
                    viewModel.onAction(action: .onTappedSwapIcon)
                } label: {
                    Image(systemName: viewModel.uiState.swapIcon)
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                }
                
                
                
                NavigationLink {
                    AirportList(viewModel: AirportListViewModel(),
                                selectedFromLocation: $viewModel.selectedFromLocation,
                                selectedToLocation: $viewModel.selectedToLocation,
                                searchType: .forTo)
                } label: {
                    LocationView(
                        title: viewModel.uiState.toTitle,
                        locationTitle: viewModel.locationState.toText)
                }
                HStack{
                  
                    
                   
                    
                   NavigationLink {
                       DateListView(viewModel: DateListViewModel(),
                                    depatureDate: $viewModel.depatureDate,
                                    returnDate: $viewModel.returnDate, type: true)
                    } label: {
                    DateView(title: viewModel.uiState.departureTitle,
                             date: viewModel.dateState.depatureDate)
                    }
                    
                    NavigationLink {
                        DateListView(viewModel: DateListViewModel(),
                                     depatureDate: $viewModel.depatureDate,
                                     returnDate: $viewModel.returnDate, type: false)
                    } label: {
                    !viewModel.dateState.returnVisible ?
                    DateView(title: viewModel.uiState.returnTitle,
                             date: viewModel.dateState.returnDate) : nil
                    }
                    
                }
                NavigationLink {
                    PassengerSelectView(viewModel: PassengerSelectViewModel(),
                                        passengerList: $viewModel.passengerList)
                } label: {
                    PassengerView(title: viewModel.uiState.passenger,
                                  passenger:viewModel.uiState.passengerText)
                }
                
                NavigationLink {
                    DepartureTicketListView(
                        viewModel: DepartureTicketListViewModel(),
                        fromAirport: viewModel.selectedFromLocation,
                        toAirport: viewModel.selectedToLocation,
                        depatureDate: viewModel.depatureDate,
                        returnDate: viewModel.returnDate
                       )
                    
                } label: {
                    Text(viewModel.uiState.searchButtonTitle)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth:.infinity)
                        .frame(height:40)
                        .background(Color(hex: viewModel.uiState.searchButtonColor))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }.disabled(viewModel.uiState.searchButtonStatus)
              
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
            .onAppear{
                viewModel.updateLocation()
                viewModel.updateDate()
                viewModel.updatePassengerValue()
                
            }
        
    }
}




#Preview {
    HomeView(viewModel: HomeViewModel())
}
