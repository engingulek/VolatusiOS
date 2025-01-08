//
//  AirportListViewModelTests.swift
//  VolatusTests
//
//  Created by Engin Gülek on 8.01.2025.
//

import Foundation
import Foundation
import XCTest
@testable import Volatus

final class AirportListViewModelTests : XCTestCase {
    private var viewModel:AirportListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = AirportListViewModel()
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
    
    func test_onChangeSearchText_retrunNotEmptyMessage(){
        viewModel.onAppear()
        viewModel.onActions(action: .onChangeSearchText("Istanbul Airport"))
        
        XCTAssertEqual(
            TextTheme.defaultEmpty.rawValue,
            viewModel.uiState.listState.message,
        "listState message is not correct")
        
        XCTAssertFalse(viewModel.uiState.listState.state,
                       "listState.state is not false")
        
    }
    
}
