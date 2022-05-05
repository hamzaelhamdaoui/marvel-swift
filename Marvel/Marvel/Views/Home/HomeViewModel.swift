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
    var fetchError = Observable<Error?>(nil)
    var fetchCharactersUseCase = FetchCharactersUseCase()

    func fetchCharacters(start: Int?, limit: Int?, onSuccess: ((Bool) -> Void)?) {
        isAnimating.value = true
        fetchCharactersUseCase.execute(start: start, limit: limit, searchText: searchText.value ?? "") { characters in
            self.isAnimating.value = false
            self.characters.value.append(contentsOf: characters)
            if characters.isEmpty {
                onSuccess?(false)
            } else {
                onSuccess?(true)
            }
        } onError: { error in
            self.isAnimating.value = false
            self.fetchError.value = error
            onSuccess?(false)
        }
    }
}
