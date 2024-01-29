//
//  MockTestCases.swift
//  SternXTaskTests
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import XCTest
import RxSwift
import RxSwiftExt

@testable import SternXTask

final class MockTestCases: XCTestCase {

    var disposeBag: DisposeBag!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        try super.tearDownWithError()
    }

    func testMockAPIClient() {
        let mockClient = MockAPIClient()
        let client: APIClient = mockClient
        client.execute(request: APIParametersRequest(url: ""), completion: { (_: Result<Bool, Error>) in })
        XCTAssert(mockClient.isCalled, "The `execute(request:, completion:)` method is not called.")
    }
    
    func testMockAPIRequest() throws {
        let mockAPIRequest = MockAPIRequest()
        let request: APIRequest = mockAPIRequest
        _ = try request.request()
        XCTAssert(mockAPIRequest.isCalled, "The `request()` method is not called.")
    }
    
    func testMockPostRepository() {
        let mockRepo = MockPostRepo()
        let repo: PostRepository = mockRepo
        repo.getPosts().subscribe().disposed(by: disposeBag)
        XCTAssert(mockRepo.isCalled, "The `getPosts` method is not called.")
    }
    
    func testMockDataProcessing() {
        let mockDataProcessing = MockDataProcessingStrategy()
        let processorStrategy: DataProcessingStrategy = mockDataProcessing
        processorStrategy.process(data: [], completion: { _ in })
        XCTAssert(mockDataProcessing.isCalled, "The `process(data:,completion:)` method is not called.")
    }
    
    func testMockReportUseCase() {
        let mockUseCase = MockReportUsecase()
        let usecase: ReportUsecase = mockUseCase
        usecase.getPostReport(ascending: false).asObservable()
            .catchErrorJustComplete().subscribe().disposed(by: disposeBag)
        XCTAssert(mockUseCase.isCalled, "The 'getPostReport' method is not called.")
    }

}
