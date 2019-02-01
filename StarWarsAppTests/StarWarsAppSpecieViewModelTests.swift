//
//  StarWarsAppSpeciesViewModelTests.swift
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

class StarWarsAppspecieViewModelTests: XCTestCase {

    private var specieViewModel: SpecieViewModel!

    // specie constants
    private final let specieName = "Yoda specie"
    private final let specieClassification = "Unown"
    private final let specieAverageHeight = "1"
    private final let specieLanguage = "Yodaniano"
    private final let specieHomeworldURL = "https://swapi.co/api/planets/6/"
    private final let specieHomeworldURLResourceIndex = 6
    private final let specieHomeworld = "Bespin" // this should be the planet 12 name

    override func setUp() {
        super.setUp()
        mockupSpecieViewModel()
    }

    private func mockPlanetResponse() -> (_ resourcePath: String) -> Driver<Response<PlanetResponse>> {
        return { _ in
            let planetResponse =
                PlanetResponse(population: "", gravity: "", diameter: "", rotationPeriod: "",
                               orbitalPeriod: "", name: self.specieHomeworld, climate: "",
                               terrain: "", surfaceWater: "", residents: ["", ""])
            let response = Response.success(planetResponse)
            return Driver.of(response)
        }
    }

    private func mockupSpecieViewModel() {
        let specie =
            Specie(averageHeight: specieAverageHeight, language: specieLanguage,
                   homeworld: specieHomeworldURL, name: specieName, classification: specieClassification)
        specieViewModel = SpecieViewModel(request: mockPlanetResponse(), specie: specie)
    }

    // Drivers
    func testSpecieNameDriver() {
        XCTAssertEqual(try specieViewModel.specieName.asObservable().toBlocking().first(), specieName)
    }

    func testSpecieClassificationDriver() {
        XCTAssertEqual(
            try specieViewModel.specieClassification.asObservable().toBlocking().first(), specieClassification)
    }

    func testSpecieAverageHeightDriver() {
        XCTAssertEqual(
            try specieViewModel.specieAverageHeight.asObservable().toBlocking().first(), specieAverageHeight)
    }

    func testSpecieLanguageDriver() {
        XCTAssertEqual(
            try specieViewModel.specieLanguage.asObservable().toBlocking().first(), specieLanguage)
    }

    func testSpecieHomeworldDriver() {
        XCTAssertEqual(
            try specieViewModel.specieHomeworld.asObservable().toBlocking().first(), specieHomeworld)
    }

    override func tearDown() {
        specieViewModel = nil
        super.tearDown()
    }

}
