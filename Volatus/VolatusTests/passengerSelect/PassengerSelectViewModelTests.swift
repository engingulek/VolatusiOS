//
//  PassengerSelectViewModelUnitTests.swift
//  VolatusTests
//
//  Created by Engin Gülek on 8.01.2025.
//

import Foundation
import XCTest
@testable import Volatus

final class PassengerSelectViewModelTests : XCTestCase {
    private var viewModel:PassengerSelectViewModel!
    private var sharedModel:SharedModel!
    
    override func setUp() {
        super.setUp()
        viewModel = PassengerSelectViewModel()
        sharedModel = SharedModel()
    }
    
    func test_openScreen_retrunPassengerSelectState() {
        viewModel.onAppear(passengerValue: sharedModel.passengerList)
        let expectedList: [PassengerValue] = [
            .init(title: TextTheme.adultTitle.rawValue,
                  ageSpaceTitle: TextTheme.adultRangeTitle.rawValue,
                  count: 1, minusButtonStatus: true),
            .init(title: TextTheme.child.rawValue,
                  ageSpaceTitle: TextTheme.childRangeTitle.rawValue,
                  count: 0, minusButtonStatus: true),
            .init(title: TextTheme.babyTitle.rawValue,
                  ageSpaceTitle: TextTheme.babyRangeTitle.rawValue,
                  count: 0, minusButtonStatus: true)
        ]
        
        XCTAssertEqual(expectedList, 
                       viewModel.passengerSelectState.passengerList)
        
        
        XCTAssertEqual(TextTheme.passengerTitle.rawValue,
                       viewModel.passengerSelectState.passengerTitle,
                       "passengerTitle is not correct"
        )
        
        XCTAssertEqual(TextTheme.confirm.rawValue,
                       viewModel.passengerSelectState.confirmButtonTitle,
                       "confirmButtonTitle is not correct")
        
        
    }
    
    
    
    func test_whenAddPassenger_ControlMinusButton(){
        
        viewModel.onAppear(passengerValue: sharedModel.passengerList)
        
        //Adult
        viewModel.onAction(action: .passengerCountPlus(index: 0))
        
        let expectedAdult = viewModel.passengerSelectState.passengerList[0]
        XCTAssertFalse(expectedAdult.minusButtonStatus)
        
        //Child
        viewModel.onAction(action: .passengerCountPlus(index: 1))
        
        let expectedChild = viewModel.passengerSelectState.passengerList[1]
        XCTAssertFalse(expectedChild.minusButtonStatus)
        
        //Baby
        viewModel.onAction(action: .passengerCountPlus(index: 2))
        
        let expectedBaby = viewModel.passengerSelectState.passengerList[2]
        XCTAssertFalse( expectedBaby.minusButtonStatus)
    }
    
    func test_WhenAddThenRemovePassenger_ControlMinusButtonAndPassengerCount(){
        
        viewModel.onAppear(passengerValue: sharedModel.passengerList)
        
        //Adult
        viewModel.onAction(action: .passengerCountPlus(index: 0))
        viewModel.onAction(action: .passengerCountMinus(index: 0))
        
        let expectedAdult = viewModel.passengerSelectState.passengerList[0]
        XCTAssertTrue(expectedAdult.minusButtonStatus)
        XCTAssertEqual(1, expectedAdult.count)
        
        
        //Child
        viewModel.onAction(action: .passengerCountPlus(index: 1))
        viewModel.onAction(action: .passengerCountMinus(index: 1))
        
        let expectedChild = viewModel.passengerSelectState.passengerList[1]
        XCTAssertTrue(expectedChild.minusButtonStatus)
        XCTAssertEqual(0, expectedChild.count)
        
        
        //Baby
        viewModel.onAction(action: .passengerCountPlus(index: 2))
        viewModel.onAction(action: .passengerCountMinus(index: 2))
        
        let expectedBaby = viewModel.passengerSelectState.passengerList[2]
        XCTAssertTrue(expectedBaby.minusButtonStatus)
        XCTAssertEqual(0, expectedBaby.count)
     
    }
    
    
    func test_addPassenger_ReturnPassengerText(){
        viewModel.onAppear(passengerValue: sharedModel.passengerList)
        viewModel.onAction(action: .passengerCountPlus(index: 0))
        viewModel.onAction(action: .passengerCountPlus(index: 1))
        viewModel.onAction(action: .passengerCountPlus(index: 2))
        let list = viewModel.passengerSelectState.passengerList
        sharedModel.updatePassenger(list: list)
        
        XCTAssertEqual("2 Adult,1 Child,1 Baby", sharedModel.passengerText)
    }
    
}
