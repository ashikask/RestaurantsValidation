//
//  RestaurantView.swift
//  JustEatTest
//
//  Created by ., Ashika on 20/02/22.
//

import SwiftUI

/*
 1. Designed UI with swift Ui, with MVVM architecture
 2. Added sort function with default sort on average product price
 3. Added adition filter on name with search feature
 4. Uinit Test cases are covered
 */

struct RestaurantView: View {
    // Observable object of viewmodel binding
    @ObservedObject var restaurantsViewModel: RestaurantsViewModel = RestaurantsViewModel()
    
    // State variable to handle sort and search
    @State var sortClicked: Bool = false
    @State var queryString: String = ""
    
    // Static values
    static var restaurants = "Restaurants"
    
    // MARK: UI design
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                // Show restaurant cell
                ForEach(queryString == "" ? restaurantsViewModel.restauntsObject : restaurantsViewModel.serachResult(for: queryString), id: \.id) { restaurant in
                    RestaurantCellView(restaurant: restaurant)
                        .environmentObject(restaurantsViewModel)
                }
            }.onAppear {
                restaurantsViewModel.loadResatuants()
            }
            .sheet(isPresented: $sortClicked, content: {
                // Sort screen
                SortingListView { SortingKey in
                    restaurantsViewModel.selectedSortKey = SortingKey
                    restaurantsViewModel.sortData(by: SortingKey)
                }
                .environmentObject(restaurantsViewModel)
            })
            .navigationBarItems(trailing: trailingNavBarItems)
            .navigationTitle(RestaurantView.restaurants)
        }
        // SearchBar implementation
        .searchable(text: $queryString)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Trailing navigation bar for sort action
    // On click shows new screen select the sort option
    // by default sorted by average product price
    private var trailingNavBarItems: some View {
        HStack {
            Button(action: {
                sortClicked.toggle()
            }, label: {
                Image("sort")
            })
            .frame(width: 44, height: 44, alignment: .trailing)
        }
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView()
    }
}
