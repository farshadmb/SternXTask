//
//  ReportSectionItemViewModel.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

protocol ReportSectionItemViewModel {
    
    func reportTopUsersViewModel() throws -> ReportTopUsersViewModel
    
    func reportUserViewModel() throws -> ReportUserViewModel
    
}
