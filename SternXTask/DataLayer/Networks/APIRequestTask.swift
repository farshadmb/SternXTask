//
//  APIRequestTask.swift
//  SternXTask
//
//  Created by farshad on 1/28/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

protocol APIRequestTask: AnyObject {
    
    var id: UUID { get }
    
    func cancelTask()
}
