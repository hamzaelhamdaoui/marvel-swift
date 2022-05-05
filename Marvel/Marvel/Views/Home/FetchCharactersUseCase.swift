//
//  FetchCharactersUseCase.swift
//  Marvel
//
//  Created by AvantgardeIT on 5/5/22.
//

import Foundation

class FetchCharactersUseCase {
    var charactersRepository =  APIService.shared

    func execute(start: Int?, limit: Int?, searchText: String, completion: @escaping ([Character]) -> Void, onError: @escaping (Error) -> Void) {
        charactersRepository.fetchCharacters(start: start, limit: limit, searchText: searchText)
            .then { response in
                if let results = response.data?.results {
                    completion(results)
                } else {
                    onError(CommonError.genericError)
                }
            }
            .onFail { error in
                onError(error)
            }
    }
}
