//
//  PDTimerView.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit

class PDTimerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.addSubview(timeDisplay)
    }
    
    var timeDisplay: UILabel = {
        let time = UILabel(frame: .zero)
        time.textColor = UIColor.green
        time.textAlignment = NSTextAlignment.center
        
        time.text = "25:00"
        
        return time
    }()
}
