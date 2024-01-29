//
//  DataProcessingTests.swift
//  SternXTaskTests
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import XCTest
@testable import SternXTask

final class DataProcessingTests: XCTestCase {

    let dataFetcher = DataFetcherHelper()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFullPostReport() throws {
        let exp = expectation(description: #function)
        let data = try dataFetcher.getData(from: "fullPosts.json", type: [PostDto].self)
        let dataProcess = ReportDataProcessingStrategy(operationQueue: .global(qos: .default))
        dataProcess.process(data: data) { result in
            // swiftlint:disable:next force_unwrapping
            XCTAssertNil(result.failure, "The data processing met error: \(result.failure!)")
            guard case let .success(report) = result else {
                exp.fulfill()
                return
            }
            XCTAssertEqual(report.topMostUsers.count, 5, "The report does not contain top 5 member with highest post")
            exp.fulfill()
        }
            
        wait(for: [exp], timeout: 1.0)
    }
    
    func testEmptyData() throws {
        let exp = expectation(description: #function)
        let data = [PostDto]()
        let dataProcess = ReportDataProcessingStrategy(operationQueue: .global(qos: .default))
        dataProcess.process(data: data) { result in
            // swiftlint:disable:next force_unwrapping
            XCTAssertNil(result.failure, "The data processing met error: \(result.failure!)")
            guard case let .success(report) = result else {
                exp.fulfill()
                return
            }
            XCTAssertNotEqual(report.topMostUsers.count, 5, "The report does contain top 5 member with highest post")
            exp.fulfill()
        }
            
        wait(for: [exp], timeout: 1.0)
    }
    
    func testFiftyPostsReport() throws {
        let exp = expectation(description: #function)
        let data = try dataFetcher.getData(from: "halfPosts.json", type: [PostDto].self)
        let dataProcess = ReportDataProcessingStrategy(operationQueue: .global(qos: .default))
        dataProcess.process(data: data) { result in
            // swiftlint:disable:next force_unwrapping
            XCTAssertNil(result.failure, "The data processing met error: \(result.failure!)")
            guard case let .success(report) = result else {
                exp.fulfill()
                return
            }
            XCTAssertEqual(report.topMostUsers.count, 5, "The report does not contain top 5 member with highest post")
            exp.fulfill()
        }
            
        wait(for: [exp], timeout: 1.0)
    }

}
