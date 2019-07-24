//
//  PDTimerViewController.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit

class PDTimerViewController: UIViewController{
    var timerView: PDTimerView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.navigationItem.title = "Timer"
        self.view.backgroundColor = UIColor.white
        
        timerView = PDTimerView(frame:.zero)
        self.view.addSubview(timerView)
        
        

    }
}
