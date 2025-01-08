//
//  DepartureViewModelTests.swift
//  VolatusTests
//
//  Created by Engin Gülek on 8.01.2025.
//

import Foundation

import Foundation
import XCTest
@testable import Volatus

final class DepartureViewModelTests : XCTestCase {
    private var viewModel:DepartureTicketListViewModel!
    private var sharedModel:SharedModel!
    
    override  func setUp() {
        super.setUp()
        viewModel = DepartureTicketListViewModel()
        sharedModel = SharedModel()
    }
    
    
    func test_onAppear(){
        let currentDate = Date.now
        let selectedDepartureDate = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)
        sharedModel.updateDate(selectedType: .from, date: selectedDepartureDate)
        viewModel.onAppear(depatureDate: sharedModel.departureDate, returnDate: nil)
        
        let list = viewModel.dateAndPrice
        
        list.forEach { dayAndPrice in
            if dayAndPrice.date.covertDate(formatterType: .typeFour) == selectedDepartureDate?.covertDate(formatterType: .typeFour) {
                XCTAssertEqual(dayAndPrice.selectedStateColor, ColorTheme.red.rawValue)
            }else{
                XCTAssertEqual(dayAndPrice.selectedStateColor, ColorTheme.gray.rawValue)
            }
        }
    }
    
    
    func test_selectedDate(){
        let currentDate = Date.now
        let selectedDepartureDate = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)
        sharedModel.updateDate(selectedType: .from, date: selectedDepartureDate)
        viewModel.onAppear(depatureDate: sharedModel.departureDate, returnDate: nil)
        
        viewModel.onAction(action: .onTappedDate(id: 5))
        
        sharedModel.updateDate(selectedType: .from, date: viewModel.updatedDepartureDate)
        
        let list = viewModel.dateAndPrice
        
        
        list.forEach { dayAndPrice in
            if dayAndPrice.date.covertDate(formatterType: .typeFour) == sharedModel.departureDate.covertDate(formatterType: .typeFour) {
                XCTAssertEqual(dayAndPrice.selectedStateColor, ColorTheme.red.rawValue)
            }else{
                XCTAssertEqual(dayAndPrice.selectedStateColor, ColorTheme.gray.rawValue)
            }
        }
    }
}
