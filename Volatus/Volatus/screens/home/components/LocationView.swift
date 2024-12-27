//
//  LocationView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct LocationView: View {
    var body: some View {
        HStack{
            
            VStack(alignment:.leading){
                Text("From")
                    .foregroundStyle(.gray)
                    .font(.callout)
                
                
                Text("Istanbul Airtport(IST)")
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
    LocationView()
}
