//
//  APIService.swift
//  Marvel
//
//  Created by AvantgardeIT on 18/4/22.
//

import Alamofire
import Foundation
import FutureKit

protocol ServiceProtocol {
    func fetchCharacters(start: Int?, limit: Int?) -> Future<CharactersResponse>
}

class APIService: ServiceProtocol {
    static let shared: ServiceProtocol = APIService()
    private let APIKEY = "829356a53f49da37b07aa6da90cadf1d"

    func fetchCharacters(start: Int? = 1, limit: Int? = 25) -> Future<CharactersResponse> {
        var parameters = Parameters()
        parameters["apikey"] = APIKEY
        parameters["offset"] = start
        parameters["limit"] = limit

        return request(.get, Endpoint.characters, parameters: parameters)
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
                        if let data = json as? Data {
                            promise.completeWithSuccess(data)
                        } else {
                            promise.completeWithFail(CommonError())
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
