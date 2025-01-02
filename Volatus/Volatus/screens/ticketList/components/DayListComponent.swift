//
//  DayComponent.swift
//  Volatus
//
//  Created by Engin Gülek on 2.01.2025.
//

import SwiftUI

struct DayListComponent: View {
    var body: some View {
        ScrollView(.horizontal,
                   showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(1...20, id: \.self) { index in
                    
                    VStack{
                        HStack(spacing:5){
                            Text("Wed")
                                .font(.title2)
                            Text("1")
                                .fontWeight(.semibold)
                                .font(.title)
                            Text("Jun")
                                .font(.title2)
                        }
                        Text("TRY 1.550")
                        
                        Divider()
                            .frame(height: 3)
                            .background( index == 3 ? Color.red : Color.white)
                    }
               
                      
                }
            }
            .padding()
        }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .background(Color.white)
    }
}


