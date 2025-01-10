//
//  Ticket.swift
//  Volatus
//
//  Created by Engin Gülek on 10.01.2025.
//

import Foundation

struct Ticket: Codable {
    let id: Int
    let airlinesIcon: String
    let airlineName, planeType, departureClock, landingClock: String
    let price: Int
    let date: String
    let departureAirport, arrivalAirport: Airport
}



