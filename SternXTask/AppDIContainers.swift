//
//  AppDIContainers.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import Alamofire

final class AppDIContainers {
    
    lazy var apiClient: APIClient = {
        let apiClient = DefaultAPIClient(configuration: .af.default)
        return apiClient
    }()
    
    lazy var postRepository: PostRemoteRepository = {
       let reportRepo = PostRemoteRepository(client: apiClient)
        return reportRepo
    }()
    
    func makeReportViewModel() -> ReportViewModel {
        let dataProcessor = ReportDataProcessingStrategy(operationQueue: .global(qos: .utility))
        let useCase = DefaultReportUsecase(postRepository: postRepository,
                                           dataProcessorStrategy: dataProcessor)
        return ReportViewModel(useCase: useCase)
    }
    
}
