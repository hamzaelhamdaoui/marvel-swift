//
//  DetailViewModel.swift
//  Marvel
//
//  Created by AvantgardeIT on 21/4/22.
//

import Bond
import Foundation
import RealityKit

enum ResourceType {
    case comics
    case series
    case stories
    case events

    var resourceName: String {
        switch self {
        case .comics:
            return "Comics"
        case .series:
            return "Series"
        case .stories:
            return "Stories"
        case .events:
            return "Events"
        }
    }
}

class DetailViewModel {
    let dataManager: ServiceProtocol
    let character: Character
    var selectedResourceType = Observable<ResourceType>(.comics)

    init(character: Character, dataManager: ServiceProtocol = APIService.shared) {
        self.character = character
        self.dataManager = dataManager
    }

    func getItemsByResourceType() -> [Items] {
        switch selectedResourceType.value {
        case .comics:
            return character.comics?.items ?? []
        case .series:
            return character.series?.items ?? []
        case .stories:
            return character.stories?.items ?? []
        case .events:
            return character.events?.items ?? []
        }
    }
}
