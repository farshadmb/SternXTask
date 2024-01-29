//
//  Font+Styles.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

    /// Scaled and styled version of any custom Font
    ///
    /// - Parameters:
    ///   - name: Name of the Font
    ///   - textStyle: The text style i.e Body, Title, ...
    /// - Returns: The scaled custom Font version with the given textStyle
    static func scaledFont(name: String, textStyle: UIFont.TextStyle) -> UIFont {

        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)

        guard let customFont = UIFont(name: name, size: fontDescriptor.pointSize) else {
            fatalError("Failed to load the \(name) font.")
        }

        return UIFontMetrics.default.scaledFont(for: customFont)
    }
    
    func scaledFont(textStyle: UIFont.TextStyle) -> UIFont {

        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)

        guard let customFont = UIFont(name: fontName, size: fontDescriptor.pointSize) else {
            fatalError("Failed to load the \(fontName) font.")
        }

        return UIFontMetrics.default.scaledFont(for: customFont)
    }
}
