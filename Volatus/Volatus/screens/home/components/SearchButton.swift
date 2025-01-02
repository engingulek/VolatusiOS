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
        NavigationLink {
            TicketListView()
        } label: {
        
        }

      
    }
}

#Preview {
    SearchButton(title: "Search")
}
