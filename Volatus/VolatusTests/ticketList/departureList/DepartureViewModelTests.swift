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
    private var service:MockDepartureTicketListService!
    
    override  func setUp() {
        super.setUp()
        service = MockDepartureTicketListService()
        viewModel = DepartureTicketListViewModel(service: service )
        sharedModel = SharedModel()
    }
    
    
    func test_onAppear(){
        let currentDate = Date.now
        let selectedDepartureDate = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)
        sharedModel.updateDate(selectedType: .from, date: selectedDepartureDate)
        viewModel.onAppear(departureAirport: nil, arrivalAirport: nil, depatureDate:  sharedModel.departureDate, returnDate: nil)
        
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
        viewModel.onAppear(departureAirport: nil, arrivalAirport: nil, depatureDate:  sharedModel.departureDate, returnDate: nil)
        
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
    
    func test_ticketlist_whenAirportsarenil_Error() {
        let expectation = XCTestExpectation(description: "Async task completed")
        
        XCTAssertEqual(
            TextTheme.defaultEmpty.rawValue,
            viewModel.messageState.message,
            "listState message is not correct"
            )
        
        service.ticketList = []
        
        
        viewModel.onAppear(departureAirport: nil, arrivalAirport: nil, depatureDate:  sharedModel.departureDate, returnDate: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
           
            XCTAssertEqual(
                TextTheme.errorMessage.rawValue,
                self.viewModel.messageState.message,
                "listState message is not correct"
                )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    
    func test_ticketlist_Errorfromdatabse() {
        let expectation = XCTestExpectation(description: "Async task completed")
        
        XCTAssertEqual(
            TextTheme.defaultEmpty.rawValue,
            viewModel.messageState.message,
            "listState message is not correct"
            )
        
        service.ticketList = []
        service.mockError = true
        
        viewModel.onAppear(departureAirport: Airport(id: 1, country: "", city: "", code: "", airname: ""), arrivalAirport: Airport(id: 2, country: "", city: "", code: "", airname: ""), depatureDate:  sharedModel.departureDate, returnDate: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
           
            XCTAssertEqual(
                TextTheme.errorMessage.rawValue,
                self.viewModel.messageState.message,
                "listState message is not correct"
                )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
