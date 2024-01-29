//
//  ReportViewModel.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import RxDataSources

class ReportViewModel {
    
    let viewWillAppeared = PublishSubject<Void>()
    let retryAction = PublishSubject<Void>()
   
    typealias SectionType = SectionModel<String, ReportSectionItemViewModel>
    
    var items: Driver<[SectionType]> {
        formattedReportSub.asDriver().compactMap { $0 }
    }
    
    var error: Driver<Error> { errorSub.asDriver(onErrorDriveWith: .never()) }
    var isLoading: Driver<Bool> { loading.asDriver() }
    
    private let useCase: ReportUsecase
    let disposeBag = DisposeBag()
    
    private let reportSub = BehaviorRelay<UserPostReport?>(value: nil)
    private let formattedReportSub = BehaviorRelay<[SectionType]>(value: [])
    private let loading = BehaviorRelay<Bool>(value: false)
    private let errorSub = PublishRelay<Error>()
    
    init(useCase: ReportUsecase) {
        self.useCase = useCase
        commonInit()
    }
    
    private func commonInit() {
        viewWillAppeared.asObservable().take(1).bind(with: self) { strongSelf, _ in
            strongSelf.executeGenerateReport()
        }.disposed(by: disposeBag)
        
        retryAction.asDriver(onErrorDriveWith: .never()).debounce(.milliseconds(100))
            .drive(with: self) { strongSelf, _ in
                strongSelf.executeGenerateReport()
            }.disposed(by: disposeBag)
        
        reportSub.asObservable().unwrap().bind(with: self) { strongSelf, report in
            strongSelf.format(report: report)
        }.disposed(by: disposeBag)
    }
    
    private func executeGenerateReport() {
        guard loading.value == false else {
            return
        }
        loading.accept(true)
        let report = useCase.getPostReport(ascending: false)
            .asObservable().mapToResult().share(replay: 1, scope: .whileConnected)
            .do(onError: { [weak loading] _ in loading?.accept(false) })
        report.compactMap(\.failure).bind(to: errorSub).disposed(by: disposeBag)
        report.compactMap(\.success).bind(to: reportSub).disposed(by: disposeBag)
    }
    
    private func format(report: UserPostReport) {
        let topSection: SectionType = SectionModel(model: "Top Users",
                                      items: [ReportTopUsersViewModel(topUsers: report.topMostUsers)])
        let otherSection: SectionType = SectionModel(model: "Most Average Characters Users",
                                      items: report.users.map { ReportUserViewModel(model: $0) })
        loading.accept(false)
        formattedReportSub.accept([topSection, otherSection])
    }
    
}
