//
//  firstTrimesterLabel.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-10.
//

import Foundation
import UIKit
import SnapKit

class FirstTrimesterLabel: UILabel {
    
    // initiate
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.text = "1st Trimester"
        self.textColor = .purple
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 35)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
