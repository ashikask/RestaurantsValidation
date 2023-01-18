//
//  RestaurantsViewModel.swift
//  JustEatTest
//
//  Created by ., Ashika on 21/02/22.
//

import Foundation
import SwiftUI

final class RestaurantsViewModel: ObservableObject {
    // Restaurant model object whose value when changed observers will be notified
    @Published var restauntsObject: [Restaurant] = [Restaurant]()
    
    // To hold the current sort selection
    var selectedSortKey: SortingKey = .popularity
    
    init() {}
    
    // MARK: UI update functions
    
    /// Retrieve json response from json file and update publisher object and sort by open, to middle tpo closed by default
    func loadResatuants() {
        let restaunts: Restaurants = load("sample.json")
        restauntsObject = restaunts.restaurants ?? [Restaurant]()
        // Apply default sort on average price
        sortData(by: selectedSortKey)
    }
    
    /// search for restaurant based on name
    /// - Parameter searchTerm: name of restaurant
    /// - Returns: Array of restaurnat of type Restaurant
    func serachResult(for searchTerm: String) -> [Restaurant] {
        return restauntsObject.filter { $0.name?.contains(searchTerm) == true }
    }
    
    ///  sort by open, to middle tpo closed by default
    func defaultSort() {
        restauntsObject.sort { $0.status < $1.status }
    }
    
    /// Function checks when to display the checkmark on sort selection UI
    /// - Parameter sortKey: selected sort
    /// - Returns: Bool indicating sort by selection to be marked or not
    func shouldShowCheckmark(for sortKey: SortingKey) -> Bool {
        return sortKey.rawValue == selectedSortKey.rawValue
    }
    
    /// Sort the restaurant data based on sort key selection
    /// - Parameter sortValue: sort key selected
    func sortData(by sortValue: SortingKey) {
        switch sortValue {
        case .averageProductPrice:
            restauntsObject.sort { $0.sortingValues?.averageProductPrice ?? 0 > $1.sortingValues?.averageProductPrice ?? 0 }
        case .bestMatch:
            restauntsObject.sort { $0.sortingValues?.bestMatch ?? 0 > $1.sortingValues?.bestMatch ?? 0 }
        case .deliveryCosts:
            restauntsObject.sort { $0.sortingValues?.deliveryCosts ?? 0 < $1.sortingValues?.deliveryCosts ?? 0 }
        case .minCost:
            restauntsObject.sort { $0.sortingValues?.minCost ?? 0 < $1.sortingValues?.minCost ?? 0 }
        case .distance:
            restauntsObject.sort { $0.sortingValues?.distance ?? 0 < $1.sortingValues?.distance ?? 0 }
        case .newest:
            restauntsObject.sort { $0.sortingValues?.newest ?? 0 > $1.sortingValues?.newest ?? 0 }
        case .popularity:
            restauntsObject.sort { $0.sortingValues?.popularity ?? 0 > $1.sortingValues?.popularity ?? 0 }
        case .ratingAverage:
            restauntsObject.sort { $0.sortingValues?.ratingAverage ?? 0 > $1.sortingValues?.ratingAverage ?? 0 }
        }
        defaultSort()
    }
    
    /// Returns the value for the sort key selection from restuant object
    /// - Parameter restaurant: object of type Restaurant
    /// - Returns: value for the selected sort key as String
    func getCurrentSortingValue(for restaurant: Restaurant) -> String {
        switch selectedSortKey {
        case .averageProductPrice:
            return "\(restaurant.sortingValues?.averageProductPrice ?? 0)"
        case .bestMatch:
            return "\(restaurant.sortingValues?.bestMatch ?? 0)"
        case .deliveryCosts:
            return "\(restaurant.sortingValues?.deliveryCosts ?? 0)"
        case .minCost:
            return  "\(restaurant.sortingValues?.minCost ?? 0)"
        case .distance:
            return "\(restaurant.sortingValues?.distance ?? 0)"
        case .newest:
            return "\(restaurant.sortingValues?.newest ?? 0)"
        case .popularity:
            return "\(restaurant.sortingValues?.popularity ?? 0)"
        case .ratingAverage:
            return "\(restaurant.sortingValues?.ratingAverage ?? 0)"
        }
    }
    
}
