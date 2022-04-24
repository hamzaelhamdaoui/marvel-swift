//
//  HomeViewModel.swift
//  Marvel
//
//  Created by AvantgardeIT on 18/4/22.
//

import Bond
import Foundation
import FutureKit
import ReactiveKit

class HomeViewModel {
    var dataManager: ServiceProtocol
    var characters = Observable<[Character]>([])
    var searchText = Observable<String?>("")
    var isAnimating = Observable<Bool>(false)
    var fetchError = Observable<Error?>(nil)

    init(dataManager: ServiceProtocol = APIService.shared) {
        self.dataManager = dataManager
    }

    func fetchCharacters(start: Int?, limit: Int?) -> Future<CharactersResponse> {
        isAnimating.value = true
        return dataManager.fetchCharacters(start: start, limit: limit, searchText: searchText.value ?? "")
            .then { response in
                self.isAnimating.value = false
                if let results = response.data?.results {
                    self.characters.value.append(contentsOf: results)
                }
            }
            .onFail { error in
                self.isAnimating.value = false
                self.fetchError.value = error
            }
    }
}
