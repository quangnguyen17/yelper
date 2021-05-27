//
//  Restaurant.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/24/21.
//

import Foundation

// MARK: - Result
struct NetworkResult: Decodable {
    let businesses: [Business]
    let region: Region
}

// MARK: - Business
struct Business: Decodable {
    let id, alias, name: String
    let image_url: String
    let is_closed: Bool
    let url: String
    let review_count: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Center
    let location: Location
    let phone, display_phone: String
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
    let zip_code: String
    let country: String
    let state: String
    let display_address: [String]
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
