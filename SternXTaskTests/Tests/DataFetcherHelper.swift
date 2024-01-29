//
//  DataFetcherHelper.swift
//  SternXTaskTests
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

final class DataFetcherHelper {
    
    func getData<T: Decodable>(from fileName: String, type: T.Type = T.self) throws -> T {
        
        guard let url = Bundle(for: Self.self).url(forResource: fileName, withExtension: nil) else {
            let error = URLError(.fileDoesNotExist)
            throw error
        }
        
        let data = try Data(contentsOf: url)
        let object = try JSONDecoder().decode(type, from: data)
        return object
    }
    
}
