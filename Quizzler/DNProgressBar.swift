//
//  DNProgressBar.swift
//  Quizzler
//
//  Created by Daniel on 16.07.2022.
//

import Foundation
import UIKit

class DNProgressBar: UIProgressView {
    init() {
        super.init(frame: .zero)
    }
    
    convenience init (xScale: CGFloat, yScale: CGFloat, progress: Float){
        self.init()
        setProgress(progress, animated: true)
        trackTintColor = .white
        tintColor = .black
        transform = self.transform.scaledBy(x: xScale, y: yScale)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
