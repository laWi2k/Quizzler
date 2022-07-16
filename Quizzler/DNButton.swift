//
//  DNButton.swift
//  Quizzler
//
//  Created by Daniel on 11.07.2022.
//

import Foundation
import UIKit

class DNButton: UIButton {
    init() {
        super.init(frame: .zero)
    }
    
    convenience init (title: String){
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 16
        titleLabel?.font = .boldSystemFont(ofSize: 40)
        setTitleColor(.black, for: .normal)
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
