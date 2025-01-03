//
//  DayComponent.swift
//  Volatus
//
//  Created by Engin Gülek on 2.01.2025.
//

import SwiftUI

struct DayListComponent: View {
    let list : [DayAndPrice]
    let onTap:(Int) -> Void
    @EnvironmentObject var sharedModel : SharedModel
    var body: some View {
        ScrollView(.horizontal,
                   showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(list, id: \.id) { value in
                    
                    VStack{
                        HStack(spacing:5){
                            
                            Text(value.date.covertDate(formatterType: .typeFour))
                                .font(.title2)
                        
                        }
                        Text("TRY \(value.price)")
                        
                        Divider()
                            .frame(height: 3)
                            .background(Color(hex: value.selectedStateColor))
                    }.foregroundStyle(Color(hex: value.selectedStateColor))
                        .onTapGesture {
                            onTap(value.id)
                          //  sharedModel.updateDate(type: true, date: Date.now)
                           
                        }
                                         
                }
            }
            .padding()
        }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .background(Color.white)
    }
}


