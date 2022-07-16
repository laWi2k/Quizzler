//
//  DNLabel.swift
//  Quizzler
//
//  Created by Daniel on 16.07.2022.
//

import Foundation
import UIKit

class DNLabel: UILabel {
    init() {
        super.init(frame: .zero)
    }
    
    convenience init (contentText: String){
        self.init()
        text = contentText
        textColor = .black
        textAlignment = .center
        font = .boldSystemFont(ofSize: 25)
        layer.cornerRadius = 16
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
