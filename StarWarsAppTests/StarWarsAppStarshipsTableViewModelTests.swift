//
//  StarWarsAppStarshipTableViewModelTests.swift
//  StarWarsAppTests
//
//  Created by Josue on 1/22/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import RxCocoa

@testable import StarWarsApp

class StarWarsAppStarshipsTableViewModelTests: XCTestCase {

    private var starshipsTableViewModel: StarshipsTableViewModel!

    private var starshipList: [Starship]!
    private var starshipListAfterFilter: [Starship]!

    override func setUp() {
        super.setUp()
        mockupStarshipList()
        mockupStarshipTableViewModel()
    }

    private func mockupStarshipList() {
        let starship1 =
            Starship(passengers: "1", length: "21", name: "Death Star",
                     manufacturer: "Some bad people", starshipClass: "Star")
        let starship2 =
            Starship(passengers: "2", length: "22", name: "Millenium Falcon",
                     manufacturer: "Some bad people", starshipClass: "Star")
        let starship3 =
            Starship(passengers: "3", length: "23", name: "Jay Jay the plane",
                     manufacturer: "Some bad people", starshipClass: "Star")
        let starship4 =
            Starship(passengers: "4", length: "24", name: "Death Star",
                     manufacturer: "Some bad people", starshipClass: "Star")
        let starship5 =
            Starship(passengers: "5", length: "25", name: "Death Star",
                     manufacturer: "Some bad people", starshipClass: "Star")
        let starship6 =
            Starship(passengers: "6", length: "26", name: "Death Star",
                     manufacturer: "Some bad people", starshipClass: "Star")
        let starship7 =
            Starship(passengers: "7", length: "27", name: "Death Star",
                    manufacturer: "Some bad people", starshipClass: "Star")
        let starship8 =
            Starship(passengers: "8", length: "28", name: "Death Star",
                     manufacturer: "Some bad people", starshipClass: "Star")
        let starship9 =
            Starship(passengers: "9", length: "29", name: "Death Star",
                     manufacturer: "Some bad people", starshipClass: "Star")
        let starship10 =
            Starship(passengers: "10", length: "20", name: "Death Star",
                     manufacturer: "Some bad people", starshipClass: "Star")
        starshipList =
            [starship1, starship2, starship3, starship4, starship5,
            starship6, starship7, starship8, starship9, starship10]
        starshipListAfterFilter = [starship3]
    }

    private func mockStarshipsResponse() -> (_ index: Int) -> Driver<Response<StarshipsResponse>> {
        return { index in
            let starshipsResponse = StarshipsResponse(count: 0, next: "", previous: "", starships: self.starshipList)
            let response = Response.success(starshipsResponse)
            return Driver.of(response)
        }
    }

    private func mockupStarshipTableViewModel() {
        starshipsTableViewModel = StarshipsTableViewModel(request: mockStarshipsResponse())
    }

    // Drivers
    func testStarshipListDriver() {
        XCTAssertEqual(try starshipsTableViewModel.modelList.asObservable().toBlocking().first(), starshipList!)
    }

    func testStarshipListDriverAfterFilter() {
        starshipsTableViewModel.filterSource.accept("jay")
        XCTAssertEqual(try
            starshipsTableViewModel.modelList.asObservable().toBlocking().first(), starshipListAfterFilter)
    }

    override func tearDown() {
        starshipsTableViewModel = nil
        super.tearDown()
    }

}
