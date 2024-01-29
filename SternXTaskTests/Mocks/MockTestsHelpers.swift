//
//  MockTestsHelpers.swift
//  SternXTaskTests
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import RxSwift
@testable import SternXTask

final class MockAPIClient: APIClient {
    
    var isCalled: Bool = false
    
    func execute<T>(request: APIRequest,
                    completion: @escaping (Result<T, Error>) -> Void) -> APIRequestTask? where T: Decodable {
        isCalled = true
        return nil
    }
}

final class MockAPIRequest: APIRequest {
    
    var isCalled: Bool = false
    
    func request() throws -> URLRequest {
        isCalled = true
        return URLRequest(url: URL(fileURLWithPath: "file://test/test.file"))
    }
}

final class MockPostRepo: PostRepository {
    
    var isCalled: Bool = false
    
    func getPosts() -> Single<[PostDto]> {
        isCalled = true
        return .just([])
    }
}

final class MockDataProcessingStrategy: DataProcessingStrategy {
    
    var isCalled: Bool = false
    func process(data: [PostDto], completion: @escaping (Result<UserPostReport, Error>) -> Void) {
        isCalled = true
    }
}

final class MockReportUsecase: ReportUsecase {
    
    var isCalled: Bool = false
    
    func getPostReport(ascending: Bool) -> Single<UserPostReport> {
        isCalled = true
        return .error(NSError())
    }
}
