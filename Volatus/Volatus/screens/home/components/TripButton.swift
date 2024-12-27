//
//  TripView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct TripButton: View {
    let title:String
    let backColor:Color
    let textColor:Color
    var body: some View {
        Button(action: {
           
        }) {
            Text(title)
                .foregroundStyle(textColor)
                .fontWeight(.semibold)
                .padding()
        }
        .frame(width: 140)
        .background(backColor)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.red, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    TripButton(title: "One Way",
             backColor: .red, textColor: .white)
}
