//
//  HomeView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedSegment = 0
    var body: some View {
        ZStack{
            VStack{
                Image("background")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                   
                Spacer()
            }
            
            VStack(spacing:15){
                HStack{
                    TripButton(
                        title: "One Way",
                        backColor: .red,
                        textColor: .white)
                    
                    TripButton(
                        title: "Rounded Trip",
                        backColor: .white,
                        textColor: .red)
                    
                }
               LocationView()
                Image(systemName: ImageTheme.swapeIcon.rawValue)
                     .font(.system(size: 30))
                    .foregroundColor(.red)
               LocationView()
                
                HStack{
                    TimeView()
                    TimeView()
                }
                PassengerView()
               SearchButton()
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(Color.white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                
                .padding(.horizontal, 20)
         
        }.ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
