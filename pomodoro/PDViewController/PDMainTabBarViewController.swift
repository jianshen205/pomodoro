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
    let timeService: PDTimerService!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.timeService = PDTimerService()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timerViewCtrl = PDTimerViewController(timerService: timeService)
        let timerViewNavCtrl = UINavigationController(rootViewController: timerViewCtrl)

        timerViewNavCtrl.tabBarItem.title = "Timer"
        
        let statViewCtrl = PDStatViewController()
        let statViewNavCtrl = UINavigationController(rootViewController: statViewCtrl)
        statViewNavCtrl.tabBarItem.title = "Stats"
        
        guard let settingViewCtrl = UIStoryboard(name: "PDSetting", bundle: nil).instantiateInitialViewController() else{return}
//        let settingViewCtrl = PDSettingViewController()
//        let settingViewNavCtrl = UINavigationController(rootViewController: settingViewCtrl)
        settingViewCtrl.tabBarItem.title = "Settings"
        
        viewControllers = [timerViewNavCtrl, statViewNavCtrl, settingViewCtrl]
        
    }
}
