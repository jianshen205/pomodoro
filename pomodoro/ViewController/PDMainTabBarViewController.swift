//
//  PDMainTabBarViewController.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit
class PDMainTabBarViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timerViewCtrl = PDTimerViewController()
        let timerViewNavCtrl = UINavigationController(rootViewController: timerViewCtrl)

        timerViewNavCtrl.tabBarItem.title = "Timer"
        
        let statViewCtrl = PDStatViewController()
        let statViewNavCtrl = UINavigationController(rootViewController: statViewCtrl)
        statViewNavCtrl.tabBarItem.title = "Stats"
        
        let settingViewCtrl = PDSettingViewController()
        let settingViewNavCtrl = UINavigationController(rootViewController: settingViewCtrl)
        settingViewNavCtrl.tabBarItem.title = "Settings"
        
        viewControllers = [timerViewNavCtrl, statViewNavCtrl, settingViewNavCtrl]
        
    }
}
