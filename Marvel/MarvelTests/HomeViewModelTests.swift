//
//  HomeViewModelTests.swift
//  MarvelTests
//
//  Created by AvantgardeIT on 24/4/22.
//

import XCTest
@testable import Marvel

class HomeViewModelTests: MarvelTests {
    let viewModel = HomeViewModel(dataManager: APIServiceMock.shared)

    func testFetchCharacters() {
        var characters = [Character]()

        viewModel.fetchCharacters(start: nil, limit: nil)
            .then { response in
                if let charactersResponse = response.data?.results {
                    characters = charactersResponse
                }
            }
        XCTAssertTrue(characters.count == 7)
    }

    func testFailFetchCharacters() {
        var characters = [Character]()
        var error: Error?
        
        viewModel.searchText.value = "testFailure"
        viewModel.fetchCharacters(start: nil, limit: nil)
            .then { response in
                if let charactersResponse = response.data?.results {
                    characters = charactersResponse
                }
            }
            .onFail { errorResponse in
                error = errorResponse
            }
        XCTAssertTrue(characters.isEmpty)
        XCTAssertNotNil(error)
    }
}
