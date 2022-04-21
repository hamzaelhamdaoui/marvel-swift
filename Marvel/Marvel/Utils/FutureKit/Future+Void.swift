//
//  Future+Void.swift
//  Telxius
//
//  Created by AvantgardeIT on 26/03/2020.
//  Copyright © 2020 AvantgardeIT. All rights reserved.
//

import FutureKit

extension Future {
    /// Converts the current future to a Future<Void>, ignoring any result.
    /// Useful for combining different Futures if you don't care about the results
    func toVoid() -> Future<Void> {
        onSuccess { _ -> Void in
            ()
        }
    }
}
