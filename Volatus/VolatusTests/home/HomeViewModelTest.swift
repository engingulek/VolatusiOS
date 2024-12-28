//
//  HomeViewModelTest.swift
//  VolatusTests
//
//  Created by Engin Gülek on 28.12.2024.
//

import Foundation
import XCTest
@testable import Volatus
final class HomeViewModelTest : XCTestCase {
    
    private var viewModel : HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    
    
    func test_when_openscreenhomeview_return_uiState(){
        
        let state = viewModel.uiState
        
        XCTAssertEqual("background",
                       state.backImage,
                       "backImage is not correct")
        
        XCTAssertEqual(ImageTheme.swapeIcon.rawValue,
                       state.swapIcon,
                       "swapIcon is not correct")
       
        XCTAssertEqual(TextTheme.search.rawValue,
                       state.searchButtonTitle,
                       "searchButtonTitle is not correct")
        
        XCTAssertEqual(TextTheme.oneWay.rawValue,
                       state.oneWayTitle,
                       "oneWayTitle is not correct")
        
        XCTAssertEqual(TextTheme.roundedTitle.rawValue,
                       state.roundedTitle,
                       "roundedTitle is not correct")
        
        
        XCTAssertEqual(TextTheme.departure.rawValue,
                       state.departureTitle,
                       "departureTitle is not correct")
        
        XCTAssertEqual(TextTheme.returnTitle.rawValue,
                       state.returnTitle,
                       "returnTitle is not correct")
        
        XCTAssertEqual(TextTheme.fromTitle.rawValue,
                       state.fromTitle,
                       "fromTitle is not correct")
        
        
        XCTAssertEqual(TextTheme.toTitle.rawValue,
                       state.toTitle,
                       "toTitle is not correct")
        
        
        XCTAssertEqual(TextTheme.passenger.rawValue,
                       state.passenger,
                       "passenger is not correct")
    }
    
    
    func test_when_openscreenhomeview_return_TripTypeState(){
        let state = viewModel.tripTypeState
        
        let oneWayTripeType = state.oneWayTripeType
        XCTAssertEqual(ColorTheme.white.rawValue,
                       oneWayTripeType.textColor,
                       "textColor of oneWayTripeType is not correcnt")
        
        XCTAssertEqual(ColorTheme.red.rawValue,
                       oneWayTripeType.backColor,
                       "backColor of oneWayTripeType is not correcnt")
        
        let roundedTripeType = state.roundedTripeType
        
        XCTAssertEqual(ColorTheme.red.rawValue,
                       roundedTripeType.textColor,
                       "textColor of oneWayTripeType is not correcnt")
        
        XCTAssertEqual(ColorTheme.white.rawValue,
                       roundedTripeType.backColor,
                       "backColor of oneWayTripeType is not correcnt")
    }
    
    
    func test_when_openscreenhomeview_return_LocationState(){
        let state = viewModel.locationState
        
        XCTAssertEqual(TextTheme.choosen.rawValue,
                       state.fromText,
                       "fromText is not correcnt")
        
        XCTAssertEqual(TextTheme.choosen.rawValue,
                       state.toText,
                       "toText is not correcnt")
    }
    
    func test_when_openscreenhomeview_return_DateState(){
        let state = viewModel.dateState
        XCTAssertTrue(state.returnVisible)
    }
    
    func test_whenOnAction_onTappedOneWay_retrun_TripTypeState_and_DateState(){
        let tripTypeState = viewModel.tripTypeState
        let dateState = viewModel.dateState
        viewModel.onAction(action: .onTappedOneWay)
        
        XCTAssertTrue(dateState.returnVisible)
        
        
        let oneWayTripeType = tripTypeState.oneWayTripeType
        XCTAssertEqual(ColorTheme.white.rawValue,
                       oneWayTripeType.textColor,
                       "textColor of oneWayTripeType is not correcnt")
        
        XCTAssertEqual(ColorTheme.red.rawValue,
                       oneWayTripeType.backColor,
                       "backColor of oneWayTripeType is not correcnt")
        
        let roundedTripeType = tripTypeState.roundedTripeType
        
        XCTAssertEqual(ColorTheme.red.rawValue,
                       roundedTripeType.textColor,
                       "textColor of oneWayTripeType is not correcnt")
        
        XCTAssertEqual(ColorTheme.white.rawValue,
                       roundedTripeType.backColor,
                       "backColor of oneWayTripeType is not correcnt")
    }
    
    func test_whenOnAction_onTappedRounded_retrun_TripTypeState_and_DateState(){
      
        viewModel.onAction(action: .onTappedRounded)
        
        let tripTypeState = viewModel.tripTypeState
        let dateState = viewModel.dateState
        
        XCTAssertFalse(dateState.returnVisible)
        
        
        let oneWayTripeType = tripTypeState.oneWayTripeType
        XCTAssertEqual(ColorTheme.red.rawValue,
                       oneWayTripeType.textColor,
                       "textColor of oneWayTripeType is not correcnt")
        
        XCTAssertEqual(ColorTheme.white.rawValue,
                       oneWayTripeType.backColor,
                       "backColor of oneWayTripeType is not correcnt")
        
        let roundedTripeType = tripTypeState.roundedTripeType
        
        XCTAssertEqual(ColorTheme.white.rawValue,
                       roundedTripeType.textColor,
                       "textColor of oneWayTripeType is not correcnt")
        
        XCTAssertEqual(ColorTheme.red.rawValue,
                       roundedTripeType.backColor,
                       "backColor of oneWayTripeType is not correcnt")
    }
    
    
    
}
