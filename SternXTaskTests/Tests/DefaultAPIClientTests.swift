//
//  DefaultAPIClientTests.swift
//  SternXTaskTests
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import XCTest
import RxSwift
@testable import SternXTask

final class DefaultAPIClientTests: XCTestCase {

    var disposeBag: DisposeBag!
    var client: DefaultAPIClient!
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        client = DefaultAPIClient(configuration: .af.default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        client = nil
        try super.tearDownWithError()
    }

    func testSuccessAPICall() {
        let request = APIParametersRequest(url: "https://jsonplaceholder.typicode.com/posts", method: .get)
        let exp = expectation(description: #function)
        client.execute(request: request) { (result: Result<[PostDto], Error>) in
            switch result {
            case .success(let values):
                print("Get response with count:\(values.count)")
            case .failure(let error):
                XCTFail("The \(#function) met error: \(error)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30.0)
    }
    
    func testFailureAPICall() {
        let request = APIParametersRequest(url: "https://jsonplaceholder.typicode.com/posts/1111", method: .get)
        let exp = expectation(description: #function)
        client.execute(request: request) { (result: Result<PostDto, Error>) in
            switch result {
            case .success(let value):
                XCTFail("The \(#function) should meet error but instead return value: \(value)")
            case .failure(let error):
                print("Get error response with error info:\(error)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30.0)
    }
    
    func testFailureRequestAPICall() {
        let request = APIParametersRequest(url: "https:jsonplaceholder.typicode.com/posts/1111", method: .get)
        let exp = expectation(description: #function)
        client.execute(request: request) { (result: Result<PostDto, Error>) in
            switch result {
            case .success(let value):
                XCTFail("The \(#function) should meet error but instead return value: \(value)")
            case .failure(let error):
                print("Get error response with error info:\(error)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 30.0)
    }
    
    func testSuccessRxAPICall() {
        let request = APIParametersRequest(url: "https://jsonplaceholder.typicode.com/posts", method: .get)
        let exp = expectation(description: #function)
        client.execute(request: request)
            .subscribe(with: exp) { (exp, result: [PostDto]) in
                print("Get response with count:\(result.count)")
                exp.fulfill()
            } onError: { exp, error in
                XCTFail("The \(#function) met error: \(error)")
                exp.fulfill()
            }.disposed(by: disposeBag)

        wait(for: [exp], timeout: 30.0)
    }
    
    func testFailureRxAPICall() {
        let request = APIParametersRequest(url: "https://jsonplaceholder.typicode.com/posts/1111", method: .get)
        let exp = expectation(description: #function)
        client.execute(request: request)
            .subscribe(with: exp) { (exp, value: PostDto) in
                XCTFail("The \(#function) should meet error but instead return value: \(value)")
                exp.fulfill()
            } onError: { exp, error in
                print("Get error response with error info:\(error)")
                exp.fulfill()
            }.disposed(by: disposeBag)

        wait(for: [exp], timeout: 30.0)
    }
}
