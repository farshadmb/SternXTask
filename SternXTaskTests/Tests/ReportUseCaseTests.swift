//
//  ReportUseCaseTests.swift
//  SternXTaskTests
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import XCTest
import Foundation
import RxSwift
@testable import SternXTask

final class ReportUseCaseTests: XCTestCase {

    let disposeBag = DisposeBag()
    let apiClient = DefaultAPIClient(configuration: .af.default)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReportUsecase() {
        let postRepo = PostRemoteRepository(client: apiClient)
        let dataProcess = ReportDataProcessingStrategy(operationQueue: .global(qos: .default))
        let useCase = DefaultReportUsecase(postRepository: postRepo, dataProcessorStrategy: dataProcess)
        
        let exp = expectation(description: #function)
        useCase.getPostReport(ascending: false).subscribe(with: exp) { exp, data in
            XCTAssert(data.topMostUsers.count > 0, "The post array does not contain any object")
            XCTAssert(data.users.count > 0, "The post array does not contain any object")
            exp.fulfill()
        } onFailure: { exp, error in
            XCTFail("The \(#function) met error: \(error.localizedDescription)")
            exp.fulfill()
        } onDisposed: { _ in
            print("Disposed")
        }.disposed(by: disposeBag)
        wait(for: [exp], timeout: 30.0)
    }

}
