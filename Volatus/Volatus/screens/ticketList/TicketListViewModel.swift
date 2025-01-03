//
//  TicketListViewModel.swift
//  Volatus
//
//  Created by Engin Gülek on 3.01.2025.
//

import Foundation

protocol TicketListViewModelProtocol : ObservableObject {
    var dateAndPrice : [(date:String,price:Int)] {get}
    func onAppear()
}


final class TicketListViewModel : TicketListViewModelProtocol {
    var dateAndPrice: [(date: String, price: Int)] = []
    
    
    func onAppear(){
        
    }
    
    
}
