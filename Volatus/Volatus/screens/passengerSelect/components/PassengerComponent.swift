//
//  PassengerComponent.swift
//  Volatus
//
//  Created by Engin Gülek on 31.12.2024.
//

import SwiftUI

struct PassengerComponent: View {
    let passenger:PassengerValue
    let minusAction:() -> Void
    let plusAction :()-> Void
    
    var body: some View {
        VStack {
            HStack {
                
                VStack(alignment:.leading){
                    Text(passenger.title)
                        .fontWeight(.semibold)
                    Text(passenger.ageSpaceTitle)
                        .font(.caption)
                }
                
                Spacer()
                HStack {
                    
                    Button(action: minusAction, label: {
                        Image(
                        systemName: ImageTheme.minus.rawValue)
                        .foregroundStyle(
                            passenger.minusButtonStatus
                            ? Color.red.opacity(0.5)
                            : Color(hex: ColorTheme.red.rawValue))
                        .font(.system(size: 30))
                    })
                    .disabled(passenger.minusButtonStatus)
                    
                    Text("\(passenger.count)")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Button(action:plusAction, label: {
                        Image(systemName: ImageTheme.plus.rawValue)
                    })
                    .foregroundStyle(Color.red)
                    .font(.system(size: 30))
                }
            }.padding()
            Divider()
                .background(Color(hex: ColorTheme.lightRed.rawValue) )
        }
    }
}


#Preview {
    PassengerComponent(
        passenger: PassengerValue(
            title: "Adult",
            ageSpaceTitle: "18+", count: 1,
            minusButtonStatus: false),
        minusAction: {}, plusAction: {})
}
