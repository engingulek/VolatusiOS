//
//  SearchButton.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

struct SearchButton: View {
    let title:String
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text(title)
                .font(.title3)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
        })
        .frame(maxWidth:.infinity)
        .frame(height:40)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    SearchButton(title: "Search")
}