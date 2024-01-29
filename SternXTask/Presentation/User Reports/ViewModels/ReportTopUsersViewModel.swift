//
//  ReportTopUsersViewModel.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

class ReportTopUsersViewModel: ReportSectionItemViewModel {
   
    let items: [UserChartEntryViewModel]
    
    let topUsers: [User]
    
    init(topUsers: [User]) {
        self.topUsers = topUsers
        self.items = topUsers.enumerated()
            .map { UserChartEntryViewModel(model: $0.element, index: $0.offset) }
    }
    
    func reportTopUsersViewModel() throws -> ReportTopUsersViewModel {
        self
    }
    
    func reportUserViewModel() throws -> ReportUserViewModel {
        throw ImplementationError(message: "The \(#function) method should not be called in ReportUserViewModel.")
    }
    
}
