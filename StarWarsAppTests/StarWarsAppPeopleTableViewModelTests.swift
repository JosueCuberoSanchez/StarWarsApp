//
//  StarWarsAppTests.swift
//  StarWarsAppTests
//
//  Created by Josue on 1/17/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import RxCocoa

@testable import StarWarsApp

class StarWarsAppPeopleTableViewModelTests: XCTestCase {

    private var peopleTableViewModel: PeopleTableViewModel!

    private var peopleList: [Person]!
    private var peopleListAfterFilter: [Person]!

    override func setUp() {
        super.setUp()
        mockupPeopleList()
        mockupPeopleTableViewModel()
    }

    private func mockupPeopleList() {
        let person1 = Person(height: "1", homeworld: "1", name: "1", gender: Person.Gender.female)
        let person2 = Person(height: "2", homeworld: "2", name: "2", gender: Person.Gender.male)
        let person3 = Person(height: "3", homeworld: "3", name: "3", gender: Person.Gender.notApplicable)
        let person4 = Person(height: "4", homeworld: "4", name: "4", gender: Person.Gender.none)
        let person5 = Person(height: "5", homeworld: "5", name: "5", gender: Person.Gender.male)
        let person6 = Person(height: "6", homeworld: "6", name: "6", gender: Person.Gender.female)
        let person7 = Person(height: "7", homeworld: "7", name: "7", gender: Person.Gender.notApplicable)
        let person8 = Person(height: "8", homeworld: "8", name: "8", gender: Person.Gender.female)
        let person9 = Person(height: "9", homeworld: "9", name: "9", gender: Person.Gender.none)
        let person10 = Person(height: "10", homeworld: "10", name: "10", gender: Person.Gender.female)
        peopleList = [person1, person2, person3, person4, person5, person6, person7, person8, person9, person10]
        peopleListAfterFilter = [person1, person10]
    }

    private func mockPeopleResponse() -> (_ index: Int) -> Driver<Response<PeopleResponse>> {
        return { index in
            let peopleResponse = PeopleResponse(count: 0, next: "", previous: "", people: self.peopleList)
            let response = Response.success(peopleResponse)
            return Driver.of(response)
        }
    }

    private func mockupPeopleTableViewModel() {
        peopleTableViewModel = PeopleTableViewModel(request: mockPeopleResponse())
    }

    // Drivers
    func testPeopleListDriver() {
        XCTAssertEqual(try peopleTableViewModel.modelList.asObservable().toBlocking().first(), peopleList!)
    }

    func testPeopleListDriverAfterFilter() {
        peopleTableViewModel.filterSource.accept("1")
        XCTAssertEqual(try
            peopleTableViewModel.modelList.asObservable().toBlocking().first(), peopleListAfterFilter)
    }

    override func tearDown() {
        peopleTableViewModel = nil
        super.tearDown()
    }

}
