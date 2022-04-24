//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by AvantgardeIT on 18/4/22.
//

import XCTest
@testable import Marvel

class MarvelTests: XCTestCase {
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
