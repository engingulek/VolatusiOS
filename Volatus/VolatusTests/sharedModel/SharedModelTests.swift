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
    
}
