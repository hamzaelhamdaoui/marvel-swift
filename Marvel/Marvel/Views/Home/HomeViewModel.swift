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
    var characters = Observable<[Character]>([])
    var searchText = Observable<String?>("")
    var isAnimating = Observable<Bool>(false)

    func fetchCharacters(start: Int?, limit: Int?) -> Future<CharactersResponse> {
        isAnimating.value = true
        return APIService.shared.fetchCharacters(start: start, limit: limit, searchText: searchText.value ?? "")
            .then { response in
                self.isAnimating.value = false
                if let results = response.data?.results {
                    self.characters.value.append(contentsOf: results)
                }
            }
            .onFail { error in
                self.isAnimating.value = false
                // TODO: Handle error
            }
    }
}
