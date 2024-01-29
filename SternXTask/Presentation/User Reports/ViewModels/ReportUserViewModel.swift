//
//  ReportUserViewModel.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import Charts

class ReportUserViewModel: ReportSectionItemViewModel {
   
    var id: String { "Id: \(model.id)" }
    var totalPosts: String { "Total Post: \(model.postCount)" }
    var averageCharacters: String { "Average Characters: \(model.averageCharacters)"}
    var totalBodyLength: String { "\(model.totalPostLength)" }
    
    let model: User
    
    init(model: User) {
        self.model = model
    }
   
    func reportTopUsersViewModel() throws -> ReportTopUsersViewModel {
        throw ImplementationError(message: "The \(#function) method should not be called in ReportUserViewModel.")
    }
    
    func reportUserViewModel() throws -> ReportUserViewModel {
        self
    }
    
}
