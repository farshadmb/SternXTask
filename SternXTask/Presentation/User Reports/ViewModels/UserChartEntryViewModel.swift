//
//  UserChartEntryViewModel.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import Charts

final class UserChartEntryViewModel {
    
    var dataEntry: ChartDataEntry {
        transformToBarChartDataEntry()
    }
    
    let model: User
    let index: Int
    
    init(model: User, index: Int) {
        self.model = model
        self.index = index
    }
    
    func formattedTitle() -> String {
        return "\(model.id)"
    }
    
    func formattedValue() -> String {
        return "\(model.postCount)"
    }
    
    private func transformToBarChartDataEntry() -> BarChartDataEntry {
        let xValue = index
        return BarChartDataEntry(x: Double(xValue), y: Double(model.postCount))
    }
}
