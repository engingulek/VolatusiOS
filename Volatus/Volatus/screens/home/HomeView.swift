//
//  HomeView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct HomeView<ViewModel:HomeViewModelProtocol>: View {
    @ObservedObject private var viewModel:ViewModel
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
                                selectedFromLocation: $viewModel.locationState.selectedFromLocation,
                                selectedToLocation: $viewModel.locationState.selectedToLocation,
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
                                selectedFromLocation: $viewModel.locationState.selectedFromLocation,
                                selectedToLocation: $viewModel.locationState.selectedToLocation,
                                searchType: .forTo)
                } label: {
                    LocationView(
                        title: viewModel.uiState.toTitle,
                        locationTitle: viewModel.locationState.toText)
                }
                HStack{
                    DateView(title: viewModel.uiState.departureTitle)
                    !viewModel.dateState.returnVisible ?
                    DateView(title: viewModel.uiState.returnTitle) : nil
                }
                PassengerView(title: viewModel.uiState.passenger)
                SearchButton(title:viewModel.uiState.searchButtonTitle)
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
                viewModel.onAppear()
            }
            
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
