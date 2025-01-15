//
//  TripView.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct TripButton: View {
    let title:String
    let tripStateData:TripeTypeData
    let action : () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(Color(hex: tripStateData.textColor))
                .fontWeight(.semibold)
                .padding()
        }
        .frame(width: 140)
        .background(Color(hex: tripStateData.backColor))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: tripStateData.backColor), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    TripButton(title: TextTheme.oneWay.rawValue,
               tripStateData: TripeTypeData(
                textColor: ColorTheme.white.rawValue,
                backColor: ColorTheme.red.rawValue), action: {})
}
