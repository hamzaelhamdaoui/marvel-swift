//
//  APIService.swift
//  Marvel
//
//  Created by AvantgardeIT on 18/4/22.
//

import Alamofire
import CryptoKit
import Foundation
import FutureKit

protocol ServiceProtocol {
    func fetchCharacters(start: Int?, limit: Int?, searchText: String) -> Future<CharactersResponse>
    func getImageURL(urlString: String, imgExtension: String, imgVariant: String) -> URL?
}

class APIService: ServiceProtocol {
    static let shared: ServiceProtocol = APIService()
    private let APIKEY = "829356a53f49da37b07aa6da90cadf1d"

    func fetchCharacters(start: Int? = 1, limit: Int? = 25, searchText: String) -> Future<CharactersResponse> {
        var parameters = getParameters()
        parameters["offset"] = start
        parameters["limit"] = limit
        if !searchText.isEmpty {
            parameters["nameStartsWith"] = searchText
        }

        return request(.get, Endpoint.characters, parameters: parameters)
    }

    private func getParameters() -> Parameters {
        var parameters = Parameters()
        let timeStamp = String(Int(Date().timeIntervalSince1970))
        let privateKey = "f568f1864cfac5629ef6514d050ce4efde17c0a9"
        let publicKey = APIKEY
        let stringToHash = timeStamp + privateKey + publicKey
        let hash = MD5(string: stringToHash)

        parameters["ts"] = timeStamp
        parameters["apikey"] = APIKEY
        parameters["hash"] = hash

        return parameters
    }

    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    func getImageURL(urlString: String, imgExtension: String, imgVariant: String = "standard_small") -> URL? {
        let path = "\(urlString.replacingOccurrences(of: "http", with: "https"))/\(imgVariant).\(imgExtension)"
        return URL(string: path)
    }
}

extension APIService {
    fileprivate func request<T>(_ method: HTTPMethod,
                                _ url: URLConvertible,
                                parameters: Parameters? = nil,
                                encoding: ParameterEncoding = URLEncoding.default) -> Future<T> where T: Codable {
        request(method, url, parameters: parameters, encoding: encoding).map {
            try JSONDecoder().decode(T.self, from: $0)
        }
    }

    fileprivate func request(_ method: HTTPMethod, _ url: URLConvertible, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default) -> Future<Data> {
        let promise = Promise<Data>()
        createRequest(method, url, parameters: parameters, encoding: encoding)
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {
                        promise.completeWithSuccess(data)
                    } else {
                        promise.completeWithFail(CommonError.genericError)
                    }
                case .failure(let error):
                    promise.completeWithFail(error)
                }
            }

        return promise.future
    }

    fileprivate func voidRequest(_ method: HTTPMethod,
                                 _ url: URLConvertible,
                                 parameters: Parameters? = nil,
                                 encoding: ParameterEncoding = URLEncoding.default) -> Future<Void> {
        let promise = Promise<Void>()
        createRequest(method, url, parameters: parameters, encoding: encoding)
            .responseData { response in
                switch response.result {
                case .success:
                    promise.completeWithSuccess(())
                case .failure(let error):
                    promise.completeWithFail(error)
                }
            }

        return promise.future
    }

    fileprivate func createRequest(_ method: HTTPMethod,
                                   _ url: URLConvertible,
                                   parameters: Parameters? = nil,
                                   encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
        let headers: [String: String]? = nil
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseString { response in
                #if DEBUG
                let request = response.request
                print("Request: ",
                      request!.httpMethod!,
                      request!.url!.absoluteString,
                      request!.httpBody.map { body in String(data: body, encoding: String.Encoding.utf8) ?? "" } ?? "")
                switch response.result {
                case .success(let value):
                    print("Response with content: ", value)
                case .failure(let error):
                    print("Response with error: \(error): \(response.data ?? Data())")
                }
                #endif
            }
            .validate()
    }
}
