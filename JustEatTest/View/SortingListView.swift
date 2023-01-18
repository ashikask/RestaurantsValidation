//
//  SortingListView.swift
//  JustEatTest
//
//  Created by ., Ashika on 22/02/22.
//

import SwiftUI

struct SortingListView: View {
    // On selection compltetion to update view on parent
    var onSortSelection: (SortingKey) -> Void
   
    // Static values
    static var sortBy = "Sort By"
    
    // Environment variable to dismiss the sheet presented
    @Environment(\.presentationMode) var presentationMode
    
    // object passed from the parent view
    @EnvironmentObject var restaurantsViewModel: RestaurantsViewModel
    
    // MARK: Sort List View
    var body: some View {
        Text(SortingListView.sortBy)
            .bold()
            .padding()
        List(SortingKey.allCases) { sortingValue in
            HStack {
                Text(sortingValue.rawValue)
                Spacer()
                if restaurantsViewModel.shouldShowCheckmark(for: sortingValue) {
                    Image("checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
            }.onTapGesture {
                onSortSelection(sortingValue)
                // Update the selected sort key
                restaurantsViewModel.selectedSortKey = sortingValue
                // dismiss the presented view
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

struct SortingListView_Previews: PreviewProvider {
    static var previews: some View {
        SortingListView { SortingKey in
        }
    }
}
