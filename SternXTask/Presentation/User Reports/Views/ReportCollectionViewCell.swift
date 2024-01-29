//
//  ReportCollectionViewCell.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import UIKit

class ReportCollectionViewCell: UICollectionViewCell, BindableType {
   
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userTotalPostLabel: UILabel!
    @IBOutlet weak var userAverageLabel: UILabel!
    
    var viewModel: ReportSectionItemViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userIdLabel.text = nil
        userTotalPostLabel.text = nil
        userAverageLabel.text = nil
    }
    
    func bindViewModel() {
        guard let viewModel = try? viewModel?.reportUserViewModel() else {
            return
        }
        userIdLabel.text = viewModel.id
        userTotalPostLabel.text = viewModel.totalPosts
        userAverageLabel.text = viewModel.averageCharacters
    }

}
