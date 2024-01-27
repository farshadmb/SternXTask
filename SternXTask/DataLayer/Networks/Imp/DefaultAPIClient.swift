//
//  DefaultAPIClient.swift
//  SternXTask
//
//  Created by farshad on 1/27/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import Alamofire

/// The default concert type for `APIClient` abstract.
final class DefaultAPIClient: APIClient {
    
    /// The `URLSession` configuration
    let configuration: URLSessionConfiguration
    
    private let session: Session
    
    /**
     The  `DispatchQueue` response serialization queue
     */
    let operationQueue: DispatchQueue
    
    /**
     Default Constructor for `DefaultAPIClient` class.
     
     - Parameters:
       - configuration: `URLSessionConfiguration` to be used to create the underlying `Alamofire.Session`.
                            Changes to this value after being passed to this initializer will have no effect.
       - operationQueue: `DispatchQueue` on which to perform all response serialization.
                            By default this queue will use the `networkResponseQueue` as its `target`.
     - Returns: The `DefaultAPIClient` class instance.
     */
    init(configuration: URLSessionConfiguration, operationQueue: DispatchQueue = .networkResponseQueue) {
        self.configuration = configuration
        self.operationQueue = operationQueue
        self.session = Session(configuration: configuration)
    }
   
    @discardableResult
    func execute<T: Decodable>(request: APIRequest,
                    completion: @escaping (Result<T, Error>) -> Void) -> APIRequestTask? {
        do {
            let urlRequest = try request.request()
            let task = session.request(urlRequest)
                .validate(statusCode: request.validStatusCodes)
                .validate(contentType: request.validContentTypes)
                .cURLDescription(calling: { description in
                    log.debug(description, tag: "\(Self.self)")
                })
                .responseString(completionHandler: { (response) in
                    log.debug(response.debugDescription, tag: "\(Self.self)")
                })
                .responseDecodable(of: T.self, queue: operationQueue) { (response) in
                    completion(response.result.flatMapError({ .failure($0.underlyingError ?? $0) }))
                }
            return task
        } catch let error {
            log.error(error)
            completion(.failure(error))
            return nil
        }
    }
}

/// :nodoc:
fileprivate extension DispatchQueue {

    /// Default queue for handling response
    static let networkResponseQueue = DispatchQueue(label: "me.ifarshad.SternXTask.networking.response",
                                                    qos: .background,
                                                    attributes: .concurrent,
                                                    autoreleaseFrequency: .workItem)
}

/// :nodoc:
extension DataRequest: APIRequestTask {
    
    func cancelTask() {
        cancel()
    }
}
