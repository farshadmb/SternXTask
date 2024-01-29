//
//  UnitTestError.swift
//  SternXTaskTests
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

/**
The Custom `Error` to use in Testing purposes.
 */
struct UnitTestError: Error, CustomStringConvertible {

    /// :nodoc:
    var description: String {
        return "UnitTestError \(message)"
    }

    /// :nodoc:
    private var message: String

    /// :nodoc:
    init(message: String) {
        self.message = message
    }
}

extension UnitTestError: LocalizedError {
    
    var errorDescription: String? {
        return description
    }
}
