//
//  AirportList.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import SwiftUI
enum SelectedType {
    case from
    case to
}
struct AirportList<ViewModel:AirportListViewModelProtocol>: View {
    
    @StateObject var viewModel:ViewModel
    @State private var searchText = ""
    @State var selectedType: SelectedType
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var sharedModel : SharedModel
    
    
    var body: some View {
        VStack{
            VStack {
                TextField(viewModel.uiState.searchPlaceholder,
                          text: $searchText)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 2)
                )
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal,10)
                .onChange(of: searchText) { _,newValue in
                    viewModel.onActions(action: .onChangeSearchText(newValue))
                }
            }.padding(.bottom,5)
         
            viewModel.uiState.listState.state ?
            AnyView(
                VStack{
                    Text(viewModel.uiState.listState.message)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(hex: ColorTheme.red.rawValue))
                }.frame(maxHeight:.infinity)
              
            )
            :
            AnyView( AirportListView(airtportList: viewModel.airportList) { airport in
                sharedModel.updateLocation(selectedType: selectedType, airport: airport)
                dismiss()
            })
           
        }.onAppear{
            viewModel.onAppear()
        }.task {
            viewModel.task()
        }.navigationTitle(NavTitle.airportList.rawValue)
    }
}

#Preview{
    AirportList(viewModel: AirportListViewModel(service: AirportListService()), selectedType: .from)
}


