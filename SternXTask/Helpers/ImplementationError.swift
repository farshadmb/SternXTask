//
//  ImplementationError.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

struct ImplementationError: Error, CustomStringConvertible {

    /// :nodoc:
    var description: String {
        return "ImplementationError \(message)"
    }

    /// :nodoc:
    private var message: String

    /// :nodoc:
    init(message: String) {
        self.message = message
    }
}

extension ImplementationError: LocalizedError {
    
    var errorDescription: String? {
        return description
    }
}
