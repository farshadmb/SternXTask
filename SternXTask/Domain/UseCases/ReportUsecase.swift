//
//  ReportUsecase.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import RxSwift

/// The Report Use-case protocol
protocol ReportUsecase: AnyObject {
    
    /// Generates users post report based on most post and average criteria's.
    ///  - Parameter ascending: a `Bool` value indicate the sort should be in ascending order or not
    ///  - Returns: a `Single<UserPostReport>` object that emit report when operation is done successfully.
    ///  - throws: emit an `Error` object when operation was failed.
    func getPostReport(ascending: Bool) -> Single<UserPostReport>
}
