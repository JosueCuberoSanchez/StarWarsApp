//
//  StarWarsAppStarshipViewModelTests.swift
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

class StarWarsAppStarshipViewModelTests: XCTestCase {

    private var starshipViewModel: StarshipViewModel!

    // Person constants
    private final let starshipName = "Death Star"
    private final let starshipManufacturer = "Some bad people"
    private final let starshipLength = "12"
    private final let starshipPassengers = "121221"
    private final let starshipClass = "Star"

    override func setUp() {
        super.setUp()
        mockupStarshipViewModel()
    }

    private func mockupStarshipViewModel() {
        let starship =
            Starship(passengers: starshipPassengers, length: starshipLength, name: starshipName,
                     manufacturer: starshipManufacturer, starshipClass: starshipClass)
        starshipViewModel = StarshipViewModel(starship: starship)
    }

    // Drivers
    func testStarshipNameDriver() {
        XCTAssertEqual(try starshipViewModel.starshipName.asObservable().toBlocking().first(), starshipName)
    }

    func testStarshipManufacturerDriver() {
        XCTAssertEqual(
            try starshipViewModel.starshipManufacturer.asObservable().toBlocking().first(), starshipManufacturer)
    }

    func testStarshipLengthDriver() {
        XCTAssertEqual(try starshipViewModel.starshipLength.asObservable().toBlocking().first(), starshipLength)
    }

    func testStarshipPassengersDriver() {
        XCTAssertEqual(try starshipViewModel.starshipPassengers.asObservable().toBlocking().first(), starshipPassengers)
    }

    func testStarshipClassDriver() {
        XCTAssertEqual(try starshipViewModel.starshipClass.asObservable().toBlocking().first(), starshipClass)
    }

    override func tearDown() {
        starshipViewModel = nil
        super.tearDown()
    }

}
