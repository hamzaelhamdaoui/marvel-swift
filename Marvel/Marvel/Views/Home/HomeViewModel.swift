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
    var characters = Observable<[Results]>([])

    func fetchCharacters(start: Int?, limit: Int?) -> Future<CharactersResponse> {
        APIService.shared.fetchCharacters(start: start, limit: limit)
            .then { response in
                if let response = response.data?.results {
                    self.characters.value = response
                }
            }
            .onFail { error in
                // TODO: Handle error
            }
    }
}
