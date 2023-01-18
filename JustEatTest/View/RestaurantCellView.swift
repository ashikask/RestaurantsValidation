//
//  RestaurantCellView.swift
//  JustEatTest
//
//  Created by ., Ashika on 22/02/22.
//

import SwiftUI

struct RestaurantCellView: View {
    var restaurant: Restaurant
    
    // object passed from the parent view
    @EnvironmentObject var restaurantsViewModel: RestaurantsViewModel
    
    // View displays name of restaurant , status and sort value selected
    var body: some View {
        VStack(alignment: .leading) {
            Text(restaurant.name ?? "")
            .fontWeight(.bold)
            HStack {
                Text(restaurant.status.rawValue)
                Spacer()
                Text(restaurantsViewModel.selectedSortKey.rawValue) + Text(": ") + Text(restaurantsViewModel.getCurrentSortingValue(for: restaurant))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct RestaurantCellView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCellView(restaurant: Restaurant(id: "1", name: "res1", status: .statusOpen, sortingValues: SortingValues(bestMatch: 1, newest: 2, ratingAverage: 1, popularity: 1, distance: 2, averageProductPrice: 1, deliveryCosts: 1, minCost: 1)))
    }
}
