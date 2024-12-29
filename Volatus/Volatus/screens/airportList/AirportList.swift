//
//  AirportList.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import SwiftUI
enum SearchType {
    case forFrom
    case forTo
}
struct AirportList<ViewModel:AirportListViewModelProtocol>: View {
    
    @ObservedObject var viewModel:ViewModel
    @Binding var selectedFromLocation:Airport?
    @Binding var selectedToLocation:Airport?
    @State private var searchText = ""
    @State var searchType: SearchType
    @Environment(\.dismiss) var dismiss
    
  
    var body: some View {
        VStack{
            VStack {
                TextField("Search Airport", text: $searchText)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.horizontal,10)
            }.padding(.bottom,5)
            
            
            AirportListView(airtportList: viewModel.airportList) { airport in
                switch searchType {
                case .forFrom:
                    selectedFromLocation = airport
                case .forTo:
                    selectedToLocation = airport
                }
                dismiss()
            }
        }.onAppear{
            viewModel.onAppear()
        }
    }
}

#Preview{
    AirportList(viewModel: AirportListViewModel(), selectedFromLocation: .constant(Airport(id: 1, name: "", code: "", city: "", country: "")), selectedToLocation: .constant(Airport(id: 1, name: "", code: "", city: "", country: "")), searchType: .forFrom)
}


