//
//  HomeViewModelTests.swift
//  MarvelTests
//
//  Created by AvantgardeIT on 24/4/22.
//

import XCTest
@testable import Marvel

class HomeViewModelTests: MarvelTests {
    let viewModel = HomeViewModel()

    func testFetchCharacters() {
        var characters = [Character]()
        var error: Error?

        viewModel.fetchCharactersUseCase.charactersRepository = APIServiceMock.shared
        viewModel.fetchCharacters(start: nil, limit: nil) { success in
            if success {
                characters = self.viewModel.characters.value
            } else {
                error = self.viewModel.fetchError.value
            }
        }
        XCTAssertTrue(characters.count == 7)
        XCTAssertNil(error)
    }

    func testFailFetchCharacters() {
        var characters = [Character]()
        var error: Error?
        
        viewModel.fetchCharactersUseCase.charactersRepository = APIServiceMock.shared
        viewModel.searchText.value = "testFailure"
        viewModel.fetchCharacters(start: nil, limit: nil) { success in
            if success {
                characters = self.viewModel.characters.value
            } else {
                error = self.viewModel.fetchError.value
            }
        }
        XCTAssertTrue(characters.isEmpty)
        XCTAssertNotNil(error)
    }
}
