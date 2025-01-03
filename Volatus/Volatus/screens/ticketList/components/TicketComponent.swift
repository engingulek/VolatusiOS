//
//  TicketComponent.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import SwiftUI

struct TicketComponent: View {
    var body: some View {
        VStack {
            //MARK: head Start
            HStack{
                Image(.testIcon)
                    .resizable()
                    .scaledToFill()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 40,height: 40)
                   
                VStack(alignment: .leading){
                    Text("Airlines Name")
                        
                        .fontWeight(.semibold)
                    Text("Plane Type")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.semibold)
                }
                Spacer()
                HStack{
                    Image(systemName: ImageTheme.clock.rawValue)
                    Text("2h:30m")
                }
            } //MARK: head finish
            
            //MARK: middle Start
            HStack{
                VStack(alignment:.leading){
                    Text("09:15")
                        .font(.title)
                    HStack(spacing:2){
                        Image(systemName: ImageTheme.airplaneDeparture.rawValue)
                        Text("Code City Name")
                            .font(.system(size: 15))
                           
                    }
                }
                Spacer()
               
                VStack(alignment:.trailing){
                    Text("11:25")
                        .font(.title)
                    HStack(spacing:2){
                        Image(systemName: ImageTheme.airplaneArrival.rawValue)
                        Text("Code City Name")
                            .font(.system(size: 15))
                    }
                }
            } //MARK: middle Finish
            Divider().padding(.vertical,10)
            //MARK: bottom Start
            HStack{
                Spacer()
                Text("TRY 1.500")
                    .font(.title2)
                    .fontWeight(.semibold)
            }//MARK: bottom Finish
        }
        .padding(.horizontal, 15)
        .padding(.vertical,15)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 8)
    }
}

#Preview {
    TicketComponent()
}
