//
//  AirportList.swift
//  Volatus
//
//  Created by Engin Gülek on 29.12.2024.
//

import SwiftUI

struct AirportListView: View {
    let airtportList:[Airport]
    let onTap:(Airport) -> Void
    var body: some View {
        VStack(alignment:.leading,spacing: 10) {
            Text(TextTheme.allAirports.rawValue)
                .fontWeight(.semibold)
                .font(.title2)
                .padding(.horizontal)
            Divider()
                .frame(height: 1)
                .background(Color.red)
            List(airtportList,id:\.id){item in
                VStack(alignment:.leading,spacing: 5){
                    Text("\(item.city),\(item.country)")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Text("\(item.code)-\(item.name)")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
                .onTapGesture {
                    onTap(item)
                }
            }.listStyle(.plain)
        }
    }
}

#Preview {
    AirportListView(airtportList: []) { _ in}
}
