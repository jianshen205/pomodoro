//
//  PDDefaults.swift
//  pomodoro
//
//  Created by JianShen on 7/27/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
enum PDSessionStatus: Double{
    case ready
    case paused
    case timing
}


class PDDefaults: UserDefaults {
    
    /*
     keys for default
     */
    enum  PDDefaultKeys: String{
        case work
        case longBreak
        case shortBreak
        case dailyGoal
        case subject
        case sessionStatus
    }
    
    let defaults = UserDefaults.standard
    
    
    func  registerDefaults () {
        defaults.register(defaults: [
            PDDefaultKeys.work.rawValue: 1500,
            PDDefaultKeys.shortBreak.rawValue: 300,
            PDDefaultKeys.longBreak.rawValue: 900,
            PDDefaultKeys.dailyGoal.rawValue:10,
            PDDefaultKeys.sessionStatus.rawValue: PDSessionStatus.ready.rawValue
            ])
    }
    
    func resetDefault() {
        setLengthOfWork(value: 1500)
        setLengthOfShortBreak(value: 300)
        setLengthOfLongBreak(value: 900)
        setDailyGoal(value: 10)
        setTimerStatus(.ready)
        
    }
    
    func setLengthOfWork(value: Int) {
        defaults.set(value, forKey: PDDefaultKeys.work.rawValue)
    }
    func setLengthOfShortBreak(value: Int) {
        defaults.set(value, forKey: PDDefaultKeys.shortBreak.rawValue)
    }
    func setLengthOfLongBreak(value: Int) {
        defaults.set(value, forKey: PDDefaultKeys.longBreak.rawValue)
    }
    func setDailyGoal(value: Int) {
        defaults.set(value, forKey: PDDefaultKeys.dailyGoal.rawValue)
    }

    func setTimerStatus(_ value: PDSessionStatus) {//这里的value要.rawvalue ??
        defaults.set(value.rawValue, forKey: PDDefaultKeys.sessionStatus.rawValue)
    }
    func getSessionStatus() -> PDSessionStatus {
        return PDSessionStatus(rawValue: defaults.double(forKey: PDDefaultKeys.sessionStatus.rawValue))!
    }
    
    func getWorkLength() -> Int{
        return defaults.integer(forKey: PDDefaultKeys.work.rawValue)
    }
    func getShortBreak() -> Int {
        return defaults.integer(forKey: PDDefaultKeys.shortBreak.rawValue)
    }
    func getLongBreak() -> Int {
        return defaults.integer(forKey: PDDefaultKeys.longBreak.rawValue)
    }
    func getDailyGoal() -> Int {
        return defaults.integer(forKey: PDDefaultKeys.dailyGoal.rawValue)
    }
    
    

}
