//
//  DefaultReportUsecase.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

final class DefaultReportUsecase: ReportUsecase {
    
    let postRepository: PostRepository
    let dataProcessorStrategy: DataProcessingStrategy
    
    init(postRepository: PostRepository,
         dataProcessorStrategy: DataProcessingStrategy) {
        self.postRepository = postRepository
        self.dataProcessorStrategy = dataProcessorStrategy
    }
    
    func getPostReport(ascending: Bool) -> Single<UserPostReport> {
        postRepository.getPosts()
            .flatMap(processAndGenerateReport(with:))
            .map { report in
                if ascending {
                    report.users = report.users.sorted { $0.averageCharacters < $1.averageCharacters }
                } else {
                    report.users = report.users.sorted { $0.averageCharacters > $1.averageCharacters }
                }
                return report
            }
    }
    
    private func processAndGenerateReport(with data: [PostDto]) -> Single<UserPostReport> {
        .deferred {
            Observable<UserPostReport>.create {[weak base = self] observer in
                guard let base = base else {
                    observer.onCompleted()
                    return Disposables.create()
                }
                
                base.dataProcessorStrategy.process(data: data) { result in
                    switch result {
                    case .success(let report):
                        observer.onNext(report)
                        observer.onCompleted()
                    case .failure(let failure):
                        observer.onError(failure)
                    }
                }
                
                return Disposables.create()
            }.asSingle()
        }
    }
}
