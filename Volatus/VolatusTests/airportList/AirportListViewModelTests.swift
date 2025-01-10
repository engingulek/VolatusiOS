//
//  AirportListViewModelTests.swift
//  VolatusTests
//
//  Created by Engin Gülek on 8.01.2025.
//

import Foundation
import XCTest
@testable import Volatus

final class AirportListViewModelTests : XCTestCase {
    private var viewModel:AirportListViewModel!
    private var service:AirportListMockService!
    
    override func setUp() {
        super.setUp()
        service = AirportListMockService()
        viewModel = AirportListViewModel(service: service)
    }
    
    
    
    func test_openView_returnAirportUiState(){
        viewModel.onAppear()
        XCTAssertEqual(
            TextTheme.searchPlaceholder.rawValue,
            viewModel.uiState.searchPlaceholder,
        "search placeholder is not correct")
        
        viewModel.onAppear()
        
        XCTAssertEqual(
            TextTheme.defaultEmpty.rawValue,
            viewModel.uiState.listState.message,
        "listState message is not correct")
        
        XCTAssertFalse(viewModel.uiState.listState.state,
                       "listState.state is not false")
        
    }
    
    func test_onChangeSearchText_retrunEmptyMessage(){
        viewModel.onAppear()
        viewModel.onActions(action: .onChangeSearchText("dsadadas"))
        
        XCTAssertEqual(
            TextTheme.notFoundAirport.rawValue,
            viewModel.uiState.listState.message,
        "listState message is not correct")
        
        XCTAssertTrue(viewModel.uiState.listState.state,
                       "listState.state is not true")
        
    }
    
    func test_onChangeSearchText_returnNotEmptyMessage()  {
        let expectation = XCTestExpectation(description: "Async task completed")
        XCTAssertEqual(
            TextTheme.defaultEmpty.rawValue,
            viewModel.uiState.listState.message,
            "listState message is not correct"
            )
     
        
        service.airportList = [
            Airport(id: 1, country: "Turkey", city: "Istanbul", code: "IST", airname: "Istanbul Airport")
        ]
        
        viewModel.task()
        viewModel.onAppear()
        viewModel.onActions(action: .onChangeSearchText("ist"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
           
            XCTAssertEqual(
                TextTheme.defaultEmpty.rawValue,
                self.viewModel.uiState.listState.message,
                "listState message is not correct"
                )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func test_onOpenScreen_ReturnErrorFromService(){
        let expectation = XCTestExpectation(description: "Async task completed")
        XCTAssertEqual(
            TextTheme.defaultEmpty.rawValue,
            viewModel.uiState.listState.message,
            "listState message is not correct"
            )
     
        service.airportList = [
         
        ]
        service.mockErrorAirportList = true
        
        viewModel.task()
        viewModel.onAppear()
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
           
            XCTAssertEqual(
                TextTheme.errorMessage.rawValue,
                self.viewModel.uiState.listState.message,
                "listState message is not correct"
                )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
