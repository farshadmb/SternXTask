//
//  ContentStateView.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import UIKit
import PureLayout

class ContentStateView: UIView {

    enum State: Int {
        case empty
        case success
        case error
        case loading
        case none
    }
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tintColor = .blue
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 3
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var actionButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        button.setTitle("Retry", for: .normal)
        return button
    }()
    
    private(set) var state = State.none {
        didSet {
            guard oldValue != state else {
                return
            }
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func updateState(to state: State) {
        guard self.state != state else {
            return
        }
        self.state = state
    }
    
    func update(toState state: State, title: String? = nil, description: String? = nil, image: UIImage? = nil) {
        updateState(to: state)
        titleLabel.text = title
        descriptionLabel.text = description
        imageView.image = image
    }

    private func commonInit() {
        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.distribution = .fill
        stackView.alignment = .center
        addSubview(stackView)
        stackView.autoAlignAxis(toSuperviewAxis: .horizontal)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16.0).priority = .defaultHigh
        stackView.autoPinEdge(toSuperviewEdge: .trailing,  withInset: 16.0).priority = .defaultHigh
        
        addSubview(imageView)
        addSubview(actionButton)
        actionButton.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),
                                                  excludingEdge: .top).forEach { $0.priority = .defaultHigh }
//        actionButton.autoSetDimension(.height, toSize: 44.0, relation: .greaterThanOrEqual)
        
        imageView.autoSetDimensions(to: CGSize(width: 75, height: 75))
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        imageView.autoPinEdge(.bottom, to: .top, of: stackView, withOffset: -20)
        
        addSubview(activityIndicatorView)
        activityIndicatorView.autoAlignAxis(toSuperviewAxis: .vertical)
        activityIndicatorView.autoPinEdge(.top, to: .bottom, of: stackView, withOffset: 20)
        
        updateUI()
    }
    
    private func updateUI() {
        var isInformativeElementsHidden = false
        var isButtonHidden = false
        var isActivityHidden = false
        var tintColor = UIColor.gray
        switch state {
        case .empty:
            activityIndicatorView.stopAnimating()
            isActivityHidden = true
            isButtonHidden = true
            self.isHidden = false
        case .loading:
            isActivityHidden = false
            isButtonHidden = true
            activityIndicatorView.startAnimating()
            self.isHidden = false
        case .success, .none:
            activityIndicatorView.stopAnimating()
            self.isHidden = true
        case .error:
            activityIndicatorView.stopAnimating()
            isActivityHidden = true
            isButtonHidden = false
            tintColor = .red
            self.isHidden = false
        }
        
        titleLabel.isHidden = isInformativeElementsHidden
        descriptionLabel.isHidden = isInformativeElementsHidden
        imageView.isHidden = isInformativeElementsHidden
        activityIndicatorView.isHidden = isActivityHidden
        actionButton.isHidden = isButtonHidden
        imageView.tintColor = tintColor
        layoutIfNeeded()
    }
    
}
