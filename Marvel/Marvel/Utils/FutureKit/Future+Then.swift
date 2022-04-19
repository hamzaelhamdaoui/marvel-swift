//
//  Future+Then.swift
//  Telxius
//
//  Created by AvantgardeIT on 26/03/2020.
//  Copyright © 2020 AvantgardeIT. All rights reserved.
//

import FutureKit

extension Future {
    // Executes the block iff the future is successful and leaves the result immutable
    @discardableResult public final func then(_ executor : Executor, block: @escaping (T) throws -> Void) -> Future<T> {
        return onSuccess(executor) { (result: T) -> Completion<T> in
            do {
                try block(result)
                return .success(result)
            }
            catch let error {
                return .fail(error)
            }
        }
    }
    @discardableResult public final func then(_ block: @escaping (T) throws -> Void) -> Future<T> {
        return then(.primary, block: block)
    }
}
