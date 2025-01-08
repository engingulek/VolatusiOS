//
//  TextTheme.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import Foundation

enum TextTheme  : String {
    
    case defaultEmpty = ""
    /// is Search
    case search = "Search"
    /// is One Way
    case oneWay = "One Way"
    /// is Rounded Trip
    case roundedTitle = "Rounded Trip"
    /// is Departure
    case departure = "Departure"
    /// is Return
    case returnTitle = "Return"
    /// is From
    case fromTitle = "From"
    /// is To
    case toTitle = "To"
    /// is Choosen
    case choosen = "Choosen"
    /// is Passenger
    case passenger = "Passenger"
    /// is Search Airport
    case searchPlaceholder = "Search Airport"
    /// is Adult
    case adultTitle = "Adult"
    /// is 18+ age
    case adultRangeTitle = "18+ age"
    /// is Child
    case child = "Child"
    /// is 2-18 age
    case childRangeTitle = "2-18 age"
    /// is Baby
    case babyTitle = "Baby"
    /// is 0-2 age
    case babyRangeTitle = "0-2 age"
    /// is Passenger Select
    case passengerTitle = "Passenger Select"
    /// is Confirm
    case confirm = "Confirm"
    /// is June 22,2024
    case previewDate = "June 22,2024"
    /// is 1 Adult
    case previewPassengerText = "1 Adult"
    /// is All Airports
    case allAirports = "All Airports"
    
    // airport not found
    case notFoundAirport = "Airport Not Found"
}
