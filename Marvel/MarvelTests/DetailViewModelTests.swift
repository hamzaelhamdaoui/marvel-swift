//
//  DetailViewModelTests.swift
//  MarvelTests
//
//  Created by AvantgardeIT on 24/4/22.
//

import XCTest
@testable import Marvel

class DetailViewModelTests: MarvelTests {
    let homeViewModel = HomeViewModel()
    var detailViewModel: DetailViewModel?

    override func setUpWithError() throws {
        try super.setUpWithError()
        homeViewModel.fetchCharactersUseCase.charactersRepository = APIServiceMock.shared
        self.homeViewModel.fetchCharacters(start: nil, limit: nil) { _ in
            if let character = self.homeViewModel.characters.value.first {
                self.detailViewModel = DetailViewModel(character: character)
            }
        }
    }
    
    func testGetItemsByResourceType() {
        var comics = [Items]()
        var series = [Items]()
        var stories = [Items]()
        var events = [Items]()
        
        detailViewModel?.selectedResourceType.value = .comics
        comics = detailViewModel?.getItemsByResourceType() ?? []
        
        detailViewModel?.selectedResourceType.value = .series
        series = detailViewModel?.getItemsByResourceType() ?? []
        
        detailViewModel?.selectedResourceType.value = .stories
        stories = detailViewModel?.getItemsByResourceType() ?? []
        
        detailViewModel?.selectedResourceType.value = .events
        events = detailViewModel?.getItemsByResourceType() ?? []
        
        XCTAssertTrue(comics.count == 20)
        XCTAssertTrue(series.count == 20)
        XCTAssertTrue(stories.count == 20)
        XCTAssertTrue(events.count == 2)
    }

    func testResourceNames() {
        detailViewModel?.selectedResourceType.value = .comics
        XCTAssertEqual(detailViewModel?.selectedResourceType.value.resourceName, "Comics")
        
        detailViewModel?.selectedResourceType.value = .series
        XCTAssertEqual(detailViewModel?.selectedResourceType.value.resourceName, "Series")
        
        detailViewModel?.selectedResourceType.value = .stories
        XCTAssertEqual(detailViewModel?.selectedResourceType.value.resourceName, "Stories")
        
        detailViewModel?.selectedResourceType.value = .events
        XCTAssertEqual(detailViewModel?.selectedResourceType.value.resourceName, "Events")
    }
}
