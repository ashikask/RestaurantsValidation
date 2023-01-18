//
//  SortingKey.swift
//  JustEatTest
//
//  Created by ., Ashika on 22/02/22.
//

import Foundation

// MARK: Enums

enum SortingKey: String, CaseIterable {
    case averageProductPrice = "Average Product Price"
    case bestMatch = "Best Match"
    case deliveryCosts = "Delivery Costs"
    case minCost = "Min Cost"
    case distance = "Distance"
    case newest = "Newest"
    case popularity = "Popularity"
    case ratingAverage = "Rating Average"
}

extension SortingKey: Identifiable {
  var id: Self { self }
}
