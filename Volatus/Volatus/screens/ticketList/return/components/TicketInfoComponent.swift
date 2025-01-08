//
//  DepartureTicketInfoComponent.swift
//  Volatus
//
//  Created by Engin Gülek on 4.01.2025.
//

import SwiftUI

struct TicketInfoComponent: View {
    let title:String
    var body: some View {
        VStack(alignment:.leading){
            Text(title)
                .foregroundStyle(Color.red)
               
            VStack{
                HStack{
                    Text("From City 00:00")
                    Spacer()
                    Text("To City 00:00")
                }
              
                HStack{
                  
                    Text("01/01/2025")
                    Spacer()
                    Text("TRY 800.00")
                }
            }
        } .fontWeight(.semibold)
            .padding()
            .background(Color.white)
    }
}

#Preview {
    TicketInfoComponent(title: "Your Departure Flight")
}
