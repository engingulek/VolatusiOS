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
struct AirportList: View {
    let items = ["Airport 1", "Airport 2", "Airport 3", "Airport 4", "Airport 5"]
    @Binding var selectedFromLocation:String
    @Binding var selectedToLocation:String
    @State private var searchText = ""
    @State var searchType: SearchType
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            VStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.horizontal,10)
                
                
             
                
            }.padding(.bottom,5)
            
            List(items,id:\.self){item in
                VStack(alignment:.leading){
                    Text("City,Country")
                    Text("Code-\(item)")
                }.onTapGesture {
                    switch searchType {
                    case .forFrom:
                        selectedFromLocation = item
                    case .forTo:
                        selectedToLocation = item
                    }
                    dismiss()
                }
            }.listStyle(.plain)
            
           
        }
    }
}

#Preview{
    AirportList(selectedFromLocation: .constant(""), selectedToLocation: .constant(""), searchType: .forFrom)
}


