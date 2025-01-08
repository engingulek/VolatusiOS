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
                    viewModel.onChangeSearchText(
                        text: newValue)
                }
            }.padding(.bottom,5)
         
            
            AirportListView(airtportList: viewModel.airportList) { airport in
                sharedModel.updateLocation(selectedType: selectedType, airport: airport)
               
                dismiss()
            }
        }.onAppear{
            viewModel.onAppear()
        }
    }
}

#Preview{
    AirportList(viewModel: AirportListViewModel(), selectedType: .from)
}


