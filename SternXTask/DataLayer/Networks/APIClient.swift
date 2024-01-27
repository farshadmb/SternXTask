//
//  APIClient.swift
//  SternXTask
//
//  Created by farshad on 1/27/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import RxSwift

protocol APIClient: AnyObject {
    
    /// Executes the api call request
    /// - Parameters:
    ///   - request: a `APIRequest` object to be run in opration
    ///   - completion: a completion closure that called when the operation is done whether is successed or failed
    func execute<T: Decodable>(request: APIRequest, completion: @escaping (Result<T, Error>) -> Void)
    
}

extension APIClient {
    
    /// Executes the api call request (**Reactive function**)
    /// - Parameter request: a `APIClientRequest` object to be run in opration
    /// - Returns: a `Observable<T: Decodable>` object when operation is done emit the result whether.
    func execute<T: Decodable>(request: APIRequest) -> Observable<T> {
        .deferred {
            .create {[weak self] observer in
                guard let strongSelf = self else {
                    observer.onCompleted()
                    return Disposables.create {
                        request.cancelRequest()
                    }
                }
                
                strongSelf.execute(request: request) { (result: Result<T, Error>) in
                    switch result {
                    case .success(let response):
                        observer.onNext(response)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                
                return Disposables.create {
                    request.cancelRequest()
                }
                
            }
        }
    }
    
}
