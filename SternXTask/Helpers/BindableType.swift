//
//  BindableType.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import UIKit

protocol BindableType: NSObjectProtocol {

    associatedtype ViewModelType

    var viewModel: ViewModelType? { get set }

    func bindViewModel()
}

extension BindableType where Self: UIViewController {

    func bind(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension BindableType where Self: UIView {

    func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }

}

extension BindableType where Self: UITableViewCell {

    func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}

extension BindableType where Self: UICollectionViewCell {

    func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}
