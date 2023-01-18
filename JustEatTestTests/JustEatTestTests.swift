//
//  JustEatTestTests.swift
//  JustEatTestTests
//
//  Created by ., Ashika on 20/02/22.
//

import XCTest
@testable import JustEatTest

class JustEatTestTests: XCTestCase {
    let viewmodel = RestaurantsViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// Test restaurant object from json
    func testRestaurantData() {
        viewmodel.loadResatuants()
        XCTAssertTrue(viewmodel.restauntsObject.count > 0)
    }
    
    /// Test search with , without search string
    func testSearch() {
        viewmodel.loadResatuants()
        let serachResultContent = viewmodel.serachResult(for: "Roti")
        XCTAssertTrue(serachResultContent.count == 1)
        
        let serachResultNoResult = viewmodel.serachResult(for: "test")
        XCTAssertTrue(serachResultNoResult.count == 0)
        
        let serachResultEmptyString = viewmodel.serachResult(for: "")
        XCTAssertTrue(serachResultEmptyString.count == 0)
    }
    
    /// test for checkmark on selected sort key
    func testCheckmark() {
        viewmodel.loadResatuants()
        XCTAssertTrue(viewmodel.shouldShowCheckmark(for: .popularity))
        XCTAssertFalse(viewmodel.shouldShowCheckmark(for: .bestMatch))
        
    }
    
    /// Test case for checkinb value for sort key
    func testSortingString() {
        viewmodel.loadResatuants()
        let resturantObject = Restaurant(id: "1", name: "Tanoshii Sushi", status: .statusOpen, sortingValues: SortingValues(bestMatch: 0.0, newest: 96.0, ratingAverage: 4.5, popularity: 17.0, distance: 1190, averageProductPrice: 1536, deliveryCosts: 200, minCost: 1000))
        /*
         {
             "id": "1",
             "name": "Tanoshii Sushi",
             "status": "open",
             "sortingValues": {
                 "bestMatch": 0.0,
                 "newest": 96.0,
                 "ratingAverage": 4.5,
                 "distance": 1190,
                 "popularity": 17.0,
                 "averageProductPrice": 1536,
                 "deliveryCosts": 200,
                 "minCost": 1000
             }
         }
         */
        
        viewmodel.selectedSortKey = .averageProductPrice
        XCTAssertTrue(viewmodel.getCurrentSortingValue(for: resturantObject) == "1536")
        
        viewmodel.selectedSortKey = .bestMatch
        XCTAssertTrue(viewmodel.getCurrentSortingValue(for: resturantObject) == "0.0")
        
        viewmodel.selectedSortKey = .newest
        XCTAssertTrue(viewmodel.getCurrentSortingValue(for: resturantObject) == "96.0")
        
        viewmodel.selectedSortKey = .distance
        XCTAssertTrue(viewmodel.getCurrentSortingValue(for: resturantObject) == "1190")
        
        viewmodel.selectedSortKey = .popularity
        XCTAssertTrue(viewmodel.getCurrentSortingValue(for: resturantObject) == "17.0")
        
        viewmodel.selectedSortKey = .deliveryCosts
        XCTAssertTrue(viewmodel.getCurrentSortingValue(for: resturantObject) == "200")
        
        viewmodel.selectedSortKey = .minCost
        XCTAssertTrue(viewmodel.getCurrentSortingValue(for: resturantObject) == "1000")
        
    }
    
    /// Test case for sorting the array of restaurants based on sort key
    func testSortingOnSelection() {
        viewmodel.loadResatuants()
        
        viewmodel.selectedSortKey = .averageProductPrice
        viewmodel.sortData(by: viewmodel.selectedSortKey)
        XCTAssertTrue(viewmodel.restauntsObject[0].sortingValues?.averageProductPrice ?? 0 >= viewmodel.restauntsObject[1].sortingValues?.averageProductPrice ?? 0)
        
        viewmodel.selectedSortKey = .bestMatch
        viewmodel.sortData(by: viewmodel.selectedSortKey)
        XCTAssertTrue(viewmodel.restauntsObject[0].sortingValues?.bestMatch ?? 0 >= viewmodel.restauntsObject[1].sortingValues?.bestMatch ?? 0)
        
        viewmodel.selectedSortKey = .newest
        viewmodel.sortData(by: viewmodel.selectedSortKey)
        XCTAssertTrue(viewmodel.restauntsObject[0].sortingValues?.newest ?? 0 >= viewmodel.restauntsObject[1].sortingValues?.newest ?? 0)
        
        viewmodel.selectedSortKey = .distance
        viewmodel.sortData(by: viewmodel.selectedSortKey)
        XCTAssertTrue(viewmodel.restauntsObject[0].sortingValues?.distance ?? 0 <= viewmodel.restauntsObject[1].sortingValues?.distance ?? 0)
        
        viewmodel.selectedSortKey = .popularity
        viewmodel.sortData(by: viewmodel.selectedSortKey)
        XCTAssertTrue(viewmodel.restauntsObject[0].sortingValues?.popularity ?? 0 >= viewmodel.restauntsObject[1].sortingValues?.popularity ?? 0)
        
        viewmodel.selectedSortKey = .deliveryCosts
        viewmodel.sortData(by: viewmodel.selectedSortKey)
        XCTAssertTrue(viewmodel.restauntsObject[0].sortingValues?.deliveryCosts ?? 0 <= viewmodel.restauntsObject[1].sortingValues?.deliveryCosts ?? 0)
        
        viewmodel.selectedSortKey = .minCost
        viewmodel.sortData(by: viewmodel.selectedSortKey)
        XCTAssertTrue(viewmodel.restauntsObject[0].sortingValues?.minCost ?? 0 <= viewmodel.restauntsObject[1].sortingValues?.minCost ?? 0)
        
    }
}
