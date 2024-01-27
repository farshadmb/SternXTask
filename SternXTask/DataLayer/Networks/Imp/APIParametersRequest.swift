//
//  APIParametersRequest.swift
//  SternXTask
//
//  Created by farshad on 1/28/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import Alamofire

struct APIParametersRequest: APIRequest {

    /// `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    let url: URLConvertible

    /// `HTTPMethod` for the `URLRequest`. `.get` by default.
    let method: HTTPMethod

    /**
     `Parameters` (a.k.a. `[String: Any]`) value to be encoded into the `URLRequest`. `nil` by default.
     */
    let parameters: Parameters?

    /** `ParameterEncoding` to be used to encode the `parameters` value into the `URLRequest`.
                          `URLEncoding.default` by default.
     */
    let encoding: ParameterEncoding

    /**
     `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
     */
    let headers: HTTPHeaders?

    /// Closure which provides a `URLRequest` for mutation.
    typealias RequestModifier = Session.RequestModifier
    
    /**
     Default Constructor for `APIParametersRequest`
     - Parameters:
       - url: `URLConvertible` value to be used as the `URLRequest`'s `URL`.
       - method: `HTTPMethod` for the `URLRequest`. `.get` by default.
       - parameters: `Parameters` (a.k.a. `[String: Any]`) value to be encoded into the `URLRequest`. `nil` by default.
       - encoding: `ParameterEncoding` to be used to encode the `parameters` value into the `URLRequest`. `URLEncoding.default` by default.
       - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
     - Returns: instance object of `APIParametersRequest`
     */
    init(url: URLConvertible, method: HTTPMethod = .get,
         parameters: Parameters? = nil,
         encoding: ParameterEncoding = URLEncoding.default,
         headers: HTTPHeaders? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }

    // MARK: - APIRequest
    
    /// :nodoc:
    func request() throws -> URLRequest {
        
        let acceptHeader = HTTPHeader(name: "Accept", value: validContentTypes.joined(separator: ", "))
        var requestHeaders = headers ?? HTTPHeaders([acceptHeader])
        requestHeaders.add(acceptHeader)

        var request = try URLRequest(url: url, method: method, headers: requestHeaders)
        return try encoding.encode(request, with: parameters)
    }
}
