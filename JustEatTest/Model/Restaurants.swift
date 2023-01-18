//
//  Restaurants.swift
//  JustEatTest
//
//  Created by ., Ashika on 20/02/22.
//

import Foundation

// MARK: - Restaurants
struct Restaurants: Codable {
    let restaurants: [Restaurant]?
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let id, name: String?
    let status: Status
    let sortingValues: SortingValues?
}

// MARK: - SortingValues
struct SortingValues: Codable {
    let bestMatch, newest: Double?
    let ratingAverage, popularity: Double?
    let distance, averageProductPrice, deliveryCosts: Int?
    let minCost: Int?
}

enum Status: String, Codable, Comparable {
    case closed = "closed"
    case orderAhead = "order ahead"
    case statusOpen = "open"
    
    // For sorting data
    var statusCode: Int {
        switch self {
        case .closed:
            return 1
        case .orderAhead:
            return 2
        case .statusOpen:
            return 3
        }
    }
    
    static func < (lhs: Status, rhs: Status) -> Bool {
        return rhs.statusCode < lhs.statusCode
    }

}

