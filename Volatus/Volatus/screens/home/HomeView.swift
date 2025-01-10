//
//  HomeView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct HomeView<ViewModel:HomeViewModelProtocol>: View {
    
    @StateObject  var viewModel:ViewModel
    @EnvironmentObject var sharedModel : SharedModel
    
    var body: some View {
        ZStack{
            VStack{
                Image(viewModel.uiState.backImage)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                Spacer()
            }
            
            VStack(spacing:15){ //MARK: TripButtons Start
                HStack{
                    TripButton(
                        title: viewModel.uiState.oneWayTitle,
                        tripStateData: viewModel.tripTypeState.oneWayTripeType,
                        action: {viewModel.onAction(action: .onTappedOneWay)})
                    
                    TripButton(
                        title: viewModel.uiState.roundedTitle,
                        tripStateData: viewModel.tripTypeState.roundedTripeType,
                        action: {viewModel.onAction(action: .onTappedRounded)})
                }//MARK: TripButtons Finish
                
                
                
                NavigationLink {//MARK: Locations Start
                    AirportList(viewModel: AirportListViewModel(service: AirportListService()),
                                selectedType: .from).environmentObject(sharedModel)
                } label: {
                    LocationView(
                        title: viewModel.uiState.fromTitle,
                        locationTitle: sharedModel.fromText)
                }
                
                Button {
                    sharedModel.swapAction()
                } label: {
                    Image(systemName: viewModel.uiState.swapIcon.name)
                        .font(.system(size: viewModel.uiState.swapIcon.size))
                        .foregroundStyle(Color(hex: viewModel.uiState.swapIcon.color))
                }
                
                NavigationLink {
                    AirportList(viewModel: AirportListViewModel(service: AirportListService()),
                                selectedType: .to).environmentObject(sharedModel)
                } label: {
                    LocationView(
                        title: viewModel.uiState.toTitle,
                        locationTitle: sharedModel.toText)
                }//MARK: Locations Finish
                
                HStack{//MARK: Date Views Start
                    
                    NavigationLink {
                        DateListView(viewModel: DateListViewModel(),
                                     type: .from).environmentObject(sharedModel)
                    } label: {
                        DateView(title: viewModel.uiState.departureTitle,
                                 date: sharedModel.depatureDateTxet)
                    }
                    
                    NavigationLink { 
                        DateListView(viewModel: DateListViewModel(),
                                     type: .to).environmentObject(sharedModel)
                    } label: {
                        !viewModel.uiState.returnVisible || sharedModel.returnDate != nil ?
                        DateView(title: viewModel.uiState.returnTitle,
                                 date: sharedModel.returnDateText) : nil
                    }//MARK: Date Views Finish
                    
                }
                NavigationLink {//MARK: Passenger Views Start
                    PassengerSelectView(viewModel: PassengerSelectViewModel())
                        .environmentObject(sharedModel)
                } label: {
                    PassengerView(title: viewModel.uiState.passenger,
                                  passenger:sharedModel.passengerText)
                }//MARK: Passenger Views Finish
                
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
                        .frame(height:50)
                        .background(
                            sharedModel.airportState
                            ?   Color(hex: ColorTheme.lightRed.rawValue)
                            :   Color(hex: ColorTheme.red.rawValue)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(sharedModel.airportState)
            }
            .frame(maxWidth: .infinity)
            .padding(15)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .padding(.horizontal, 20)
            
        }.ignoresSafeArea()
    }
}




#Preview {
    HomeView(viewModel: HomeViewModel())
}
