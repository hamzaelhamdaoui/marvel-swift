//
//  Future+Throws.swift
//  Telxius
//
//  Created by AvantgardeIT on 26/03/2020.
//  Copyright © 2020 AvantgardeIT. All rights reserved.
//

// swiftlint: disable generic_type_name

import FutureKit

extension Future {
    public final func onSuccessTry<__Type>(_ executor: Executor, block: @escaping (_ result: T) throws -> __Type) -> Future<__Type> {
        onSuccess(executor) { result -> Completion<__Type> in
            do {
                let blockResult = try block(result)
                return .success(blockResult)
            } catch let error {
                return .fail(error)
            }
        }
    }

    public final func onSuccessTry<__Type>(_ block: @escaping (_ result: T) throws -> __Type) -> Future<__Type> {
        onSuccess { result -> Completion<__Type> in
            do {
                let blockResult = try block(result)
                return .success(blockResult)
            } catch let error {
                return .fail(error)
            }
        }
    }
}
