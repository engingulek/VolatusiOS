//
//  TicketComponent.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import SwiftUI
import Kingfisher
struct TicketComponent: View {
    let ticket:Ticket
    let onTap:() -> Void
    var body: some View {
        VStack {
            //MARK: head Start
            HStack{
                KFImage.from(url: URL(string: ticket.airlinesIcon))
                   
                VStack(alignment: .leading){
                    Text(ticket.airlineName)
                        
                        .fontWeight(.semibold)
                    Text(ticket.planeType)
                        .foregroundStyle(Color.gray)
                        .fontWeight(.semibold)
                }
                Spacer()
            } //MARK: head finish
            
            //MARK: middle Start
            HStack{
                VStack(alignment:.leading){
                    Text(ticket.departureClock)
                        .font(.title)
                    HStack(spacing:2){
                        Image(systemName: ImageTheme.airplaneDeparture.rawValue)
                        Text("\(ticket.departureAirport.code) \(ticket.departureAirport.city)")
                            .font(.system(size: 15))
                           
                    }
                }
                Spacer()
               
                VStack(alignment:.trailing){
                    Text(ticket.landingClock)
                        .font(.title)
                    HStack(spacing:2){
                        Image(systemName: ImageTheme.airplaneArrival.rawValue)
                        Text("\(ticket.arrivalAirport.code) \(ticket.arrivalAirport.city)")
                            .font(.system(size: 15))
                    }
                }
            } //MARK: middle Finish
            Divider().padding(.vertical,10)
            //MARK: bottom Start
            HStack{
                Spacer()
                Text("TRY \(ticket.price)")
                    .font(.title2)
                    .fontWeight(.semibold)
            }//MARK: bottom Finish
        }
        .padding(.horizontal, 15)
        .padding(.vertical,15)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 8)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    TicketComponent(ticket: Ticket(id: 1, airlinesIcon: "https://firebasestorage.googleapis.com/v0/b/feastly-f1988.appspot.com/o/volatus%2Fpegasus_airlines.png?alt=media&token=855a1097-4155-4db2-8c8d-7f4a2bc01532", airlineName: "Pegasus Airlines", planeType: "Airbus A320", departureClock: "08:30", landingClock: "12:00", price: 250, date: "Fri 10 Jan", departureAirport: Volatus.Airport(id: 1, country: "United States", city: "New York", code: "JFK", airname: "John F. Kennedy International Airport"), arrivalAirport: Volatus.Airport(id: 5, country: "Turkey", city: "Istanbul", code: "IST", airname: "Istanbul Airport")), onTap: {})
}
