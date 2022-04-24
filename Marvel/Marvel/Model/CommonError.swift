//
//  CommonError.swift
//  Marvel
//
//  Created by AvantgardeIT on 18/4/22.
//

import Foundation

enum CommonError: Error {
    case genericError
}

extension CommonError: CustomStringConvertible {
    var description: String {
        switch self {
        case .genericError:
            return "An error has occurred"
        }
    }
}
