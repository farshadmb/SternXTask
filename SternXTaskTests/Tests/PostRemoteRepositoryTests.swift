//
//  PostRemoteRepositoryTests.swift
//  SternXTaskTests
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import XCTest
import Foundation
import RxSwift
@testable import SternXTask

final class PostRemoteRepositoryTests: XCTestCase {

    let disposeBag = DisposeBag()
    let apiClient = DefaultAPIClient(configuration: .af.default)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessPostRemoteRepository() {
        let postRepo = PostRemoteRepository(client: apiClient)
        let exp = expectation(description: #function)
        postRepo.getPosts().subscribe(with: exp) { exp, data in
            XCTAssert(data.count > 0, "The post array does not contain any object")
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
