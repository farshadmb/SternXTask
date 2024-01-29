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
        label.font = label.font.scaledFont(textStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = label.font.scaledFont(textStyle: .subheadline)
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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.distribution = .fill
        stackView.alignment = .center
        addSubview(stackView)
        stackView.autoCenterInSuperview()
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        
        addSubview(imageView)
        addSubview(actionButton)
        actionButton.autoPinEdges(toSuperviewMarginsExcludingEdge: .top)
        imageView.autoPinEdge(toSuperviewMargin: .leading, relation: .greaterThanOrEqual).constant *= 2
        imageView.autoPinEdge(toSuperviewMargin: .trailing, relation: .greaterThanOrEqual).constant *= 2
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        imageView.autoPinEdge(.bottom, to: .top, of: stackView)
        
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
        case .loading:
            isActivityHidden = false
            isButtonHidden = true
            activityIndicatorView.startAnimating()
        case .success, .none:
            activityIndicatorView.stopAnimating()
            self.isHidden = true
        case .error:
            activityIndicatorView.stopAnimating()
            isActivityHidden = true
            isButtonHidden = true
            tintColor = .red
        }
        
        titleLabel.isHidden = isInformativeElementsHidden
        descriptionLabel.isHidden = isInformativeElementsHidden
        imageView.isHidden = isInformativeElementsHidden
        activityIndicatorView.isHidden = isActivityHidden
        actionButton.isHidden = isButtonHidden
        imageView.tintColor = tintColor
    }
    
}
