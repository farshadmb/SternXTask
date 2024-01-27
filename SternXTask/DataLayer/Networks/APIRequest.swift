//
//  APIRequest.swift
//  SternXTask
//
//  Created by farshad on 1/27/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

/// a `APIRqeuest` abstract that can be used by adapted types where is be used to send request.
protocol APIRequest {
    
    /// The  value which to be used in response status code validation.
    var validStatusCodes: Set<Int> { get }
    
    /// The value which to be used the response content type validation.
    var validContentTypes: Set<String> { get }
    
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest` object.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func request() throws -> URLRequest
    
    /// Cancel the request
    func cancelRequest()
}

/// The default implementation for `APIRequest`
extension APIRequest {
    
    var validStatusCodes: Set<Int> { Set(200..<300) }
    var validContentTypes: Set<String> { ["application/json"] }
    
}
