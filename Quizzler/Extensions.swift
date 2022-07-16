//
//  Extensions.swift
//  Quizzler
//
//  Created by Daniel on 16.07.2022.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { view in
            addArrangedSubview(view)
        }
    }
}
