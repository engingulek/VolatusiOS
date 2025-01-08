//
//  SharedModelTests.swift
//  VolatusTests
//
//  Created by Engin Gülek on 8.01.2025.
//

import Foundation
import XCTest
@testable import Volatus

final class SharedModelTests : XCTestCase {
    private var sharedModel:SharedModel!
    
    override func setUp() {
        super.setUp()
        sharedModel = SharedModel()
    }
    
    
    func test_airportState_returnTrue() {
        XCTAssertTrue(sharedModel.airportState)
    }
    
    func test_whenOnlyUpdatedFrom_retrunTrue(){
        let selectedAirportOnAirportList = Airport(
            id: 1,
            name: "Airport Name",
            code: "AN", city: "Test City", country: "Test Name")
        
        sharedModel.updateLocation(selectedType: .from, airport: selectedAirportOnAirportList)
        
        XCTAssertTrue(sharedModel.airportState)
        
    }
    
    func test_whenOnlyUpdatedYo_retrunTrue(){
        let selectedAirportOnAirportList = Airport(
            id: 1,
            name: "Airport Name",
            code: "AN", city: "Test City", country: "Test Name")
        
        sharedModel.updateLocation(selectedType: .to, airport: selectedAirportOnAirportList)
        
        XCTAssertTrue(sharedModel.airportState)
        
    }
    
    
    func test_whenUpdatedFromAndToSameAirpoert_retrunTrue(){
        let selectedAirportOnAirportList = Airport(
            id: 1,
            name: "Airport Name",
            code: "AN", city: "Test City", country: "Test Name")
        
        sharedModel.updateLocation(selectedType: .from, airport: selectedAirportOnAirportList)
        
        sharedModel.updateLocation(selectedType: .to, airport: selectedAirportOnAirportList)
        
        XCTAssertTrue(sharedModel.airportState)
    }
    
    
    func test_whenupdateLocationOnSharedModel_returnFromText(){
        let selectedAirportOnAirportList = Airport(
            id: 1,
            name: "Airport Name",
            code: "AN", city: "Test City", country: "Test Name")
        
        sharedModel.updateLocation(selectedType: .from, airport: selectedAirportOnAirportList)
        
        
        XCTAssertEqual("AN - Airport Name", 
                       sharedModel.fromText,
                       "fromText is not correct"
        )
    }
    
    
    func test_whenupdateLocationOnSharedModel_returnToText(){
        let selectedAirportOnAirportList = Airport(
            id: 1,
            name: "Airport Name",
            code: "AN", city: "Test City", country: "Test Name")
        
        sharedModel.updateLocation(selectedType: .to, airport: selectedAirportOnAirportList)
        
        
        XCTAssertEqual("AN - Airport Name",
                       sharedModel.toText,
                       "fromText is not correct"
        )
    }
    
    
    func test_whenUpdateDate_returnDepatureDateTxet(){
        sharedModel.updateDate(selectedType: .from, date: Date.now)
        
        let expectedDate = "January 08, 2025"
        
        XCTAssertEqual(expectedDate,
                       sharedModel.depatureDateTxet,
                       "depatureDateTxet is not correct")
    }
    
    func test_whenUpdateDate_returnReturnDateTxet(){
        sharedModel.updateDate(selectedType: .to, date: Date.now)
        
        let expectedDate = "January 08, 2025"
        
        XCTAssertEqual(expectedDate,
                       sharedModel.returnDateText,
                       "returnDateText is not correct")
    }
    
    func test_upateteRetrunDateAccordingtoDeparture_returnDateText(){
        let currentDate = Date.now
        let retrunDate = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)
        sharedModel.updateDate(selectedType: .from, date: Date.now)
        sharedModel.updateDate(selectedType: .to, date: retrunDate)
        
        let newDepartureDate =  Calendar.current.date(byAdding: .day, value: 5, to: currentDate)
        
        sharedModel.updateDate(selectedType: .from, date: newDepartureDate)
        
        XCTAssertEqual(sharedModel.depatureDateTxet, sharedModel.returnDateText)
        
    }
    
}
