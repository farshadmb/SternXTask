//
//  Rx+Helpers.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    
    /**
     Returns an observable sequence which success or error event is mapped to `Result<Element, Error>` value.
     - returns: An observable containing the value `Result<Element, Error>` in all cases.
    */
    func mapToResult() -> Observable<Result<Element, Error>> {
        return map { Result.success($0) }.catch { .just(Result.failure($0)) }
    }
    
    /// Returns an observable sequence which success or error event is mapped to `Result<Element, Error>` value
    /// that could be transform to transformer closure provided as a parameter
    /// - Parameter transform: A closure that element of the input sequence is being transformed with
    /// - Returns: An observable containing the value `Result<T, Error>` provided as a parameter.
    func mapToResult<T>(transform: @escaping (Element) throws -> T) -> Observable<Result<T, Error>> {
        return map { value in Result { try transform(value) } }.catch { .just(Result.failure($0)) }
    }

}

extension PrimitiveSequenceType where Trait == SingleTrait {
    
    func mapToResult() -> Single<Result<Element, Error>> {
        return map { Result.success($0) }.catch { .just(Result.failure($0)) }
    }
    
    func mapToResult<T>(transform: @escaping (Element) throws -> T) -> Single<Result<T, Error>> {
        return map { value in Result { try transform(value) } }.catch { .just(Result.failure($0)) }
    }
    
}

extension PrimitiveSequenceType where Trait == MaybeTrait {
    
    func mapToResult() -> Maybe<Result<Element, Error>> {
        return map { Result.success($0) }.catch { .just(Result.failure($0)) }
    }
    
    func mapToResult<T>(transform: @escaping (Element) throws -> T) -> Maybe<Result<T, Error>> {
        return map { value in Result { try transform(value) } }.catch { .just(Result.failure($0)) }
    }
}
