//
//  VolatusApp.swift
//  Volatus
//
//  Created by Engin Gülek on 27.12.2024.
//

import SwiftUI

@main
struct VolatusApp: App {

    @StateObject private var sharedModel = SharedModel()
    var body: some Scene {
        WindowGroup {
           // TestView()
            NavigationStack {
                HomeView(viewModel: HomeViewModel())
                    .environmentObject(sharedModel)
            }
            
           
        }
    }
}
