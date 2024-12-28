//
//  TimeView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct DateView: View {
    let title:String
    var body: some View {
        HStack{
            
            VStack(alignment:.leading){
                Text(title)
                    .foregroundStyle(.gray)
                    .font(.callout)
                
                
                Text("June 22,2024")
                    .foregroundStyle(.black)
                    .font(.callout)
                    .fontWeight(.semibold)
                
            }
            Spacer()
            
            
        }
        
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
    DateView(title: TextTheme.departure.rawValue)
}
