//
//  TimeView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct DateView: View {
    let title:String
    let date:String
    @State var testDate = Date.now
    var body: some View {
        HStack{
            
            VStack(alignment:.leading){
                Text(title)
                    .foregroundStyle(.gray)
                    .font(.callout)
                
                 Text(date)
                    .foregroundStyle(.black)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                
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
    DateView(title: TextTheme.departure.rawValue, date: "June 22,2024")
}
