//
//  APIServiceMock.swift
//  MarvelTests
//
//  Created by AvantgardeIT on 24/4/22.
//

import Foundation
import FutureKit
@testable import Marvel

class APIServiceMock: ServiceProtocol {
    static let shared: ServiceProtocol = APIServiceMock()
    
    func fetchCharacters(start: Int?, limit: Int?, searchText: String) -> Future<CharactersResponse> {
        let promise = Promise<CharactersResponse>()
        if searchText == "testFailure" {
            promise.completeWithFail(CommonError.genericError)
        }
        if let object: CharactersResponse = try? getJSONObject(for: "CharactersResponse") {
            promise.completeWithSuccess(object)
        } else {
            promise.completeWithFail(CommonError.genericError)
        }
        return promise.future
    }
    
    func getImageURL(urlString: String, imgExtension: String, imgVariant: String) -> URL? {
        let path = "\(urlString.replacingOccurrences(of: "http", with: "https"))/\(imgVariant).\(imgExtension)"
        return URL(string: path)
    }
}

extension APIServiceMock {
    func getJSONObject<T:Codable>(bundle: Bundle = Bundle(for: MarvelTests.self), for jsonName: String) throws -> T? {
        guard let jsonData = try getJSON(bundle: bundle, for: jsonName) else { return nil }
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }

    func getJSON(bundle: Bundle, for jsonName: String) throws -> Data? {
        guard let path = bundle.path(forResource: jsonName, ofType: "json") else {
            print("Could not retrieve file \(jsonName).json")
            return nil
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
}
