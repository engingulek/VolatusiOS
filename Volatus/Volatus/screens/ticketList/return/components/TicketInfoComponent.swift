//
//  DepartureTicketInfoComponent.swift
//  Volatus
//
//  Created by Engin Gülek on 4.01.2025.
//

import SwiftUI

struct TicketInfoComponent: View {
    let title:String
    let ticket:Ticket?
    var body: some View {
        
        ticket != nil ?
        VStack(alignment:.leading){
            Text(title)
                .foregroundStyle(Color.red)
               
            VStack{
                HStack{
                    Text("\(ticket!.departureAirport.city) \(ticket!.departureClock)")
                    Spacer()
                    Text("\(ticket!.arrivalAirport.city) \(ticket!.landingClock)")
                }
              
                HStack{
                  
                    Text(ticket?.date ?? "")
                    Spacer()
                 
                }
            }
        } .fontWeight(.semibold)
            .padding()
            .background(Color.white) : nil
    }
}

#Preview {
    TicketInfoComponent(title: "Your Departure Flight", ticket: Ticket(id: 1, airlinesIcon: "", airlineName: "", planeType: "", departureClock: "", landingClock: "", price: 0, date: "", departureAirport: Airport(id: 1, country: "", city: "", code: "", airname: ""), arrivalAirport: Airport(id: 2, country: "", city: "", code: "", airname: "")))
}
