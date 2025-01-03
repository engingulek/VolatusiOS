//
//  PassengerInfoScreen.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import SwiftUI

struct PassengerInfoScreen: View {
    @EnvironmentObject private var sharedModel:SharedModel
    var body: some View {
        Text("\(sharedModel.fromAirport?.name ?? "")")
        Text("\(sharedModel.toAirport?.name ?? "")")
        Text("\(sharedModel.departureDate)")
        Text("\(sharedModel.returnDate?.covertDate(formatterType: .typeFour) ?? "" )")
        
    }
}

#Preview {
    PassengerInfoScreen()
}
