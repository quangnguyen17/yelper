//
//  Restaurant.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/24/21.
//

import Foundation

// MARK: - UserLocation
struct UserLocation: Decodable {
    let latitude, longitude: Float
}

// MARK: - Business
struct Business: Decodable {
    let id, alias, name: String
    let imageURL: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Center
    let location: Location
    let phone, displayPhone: String
    let distance: Double
}

// MARK: - Category
struct Category: Decodable {
    let alias, title: String
}

// MARK: - Center
struct Center: Decodable {
    let latitude, longitude: Double
}

// MARK: - Location
struct Location: Decodable {
    let address1: String
    let address2: String?
    let address3: String?
    let city: String
    let zipCode: String
    let country: String
    let state: String
    let displayAddress: [String]
}

enum Address3 {
    case edenPlazaCafe
    case empty
    case polkGreenProduceMarket
    case theContemporaryJewishMuseum
}

enum Price {
    case empty
    case price
}

enum Transaction {
    case delivery
    case pickup
}

// MARK: - Region
struct Region: Decodable {
    let center: Center
}
