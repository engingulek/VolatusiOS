//
//  LocationView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct LocationView: View {
    let title:String
    let locationTitle:String
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text(title)
                    .foregroundStyle(.gray)
                    .font(.callout)
                
                
                Text(locationTitle)
                    .foregroundStyle(.black)
                    .font(.title3)
                    .fontWeight(.semibold)
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .padding(16)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

#Preview {
    LocationView(
        title: TextTheme.fromTitle.rawValue,
        locationTitle: "Choosen")
}
