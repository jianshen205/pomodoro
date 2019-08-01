//
//  DailyStat.swift
//  pomodoro
//
//  Created by JianShen on 8/1/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
class DailyStat:Equatable, Comparable{
    let date : Date!
    let length: Int!
    
    init(date: Date, length: Int) {
        self.date = date
        self.length = length
    }
    
    static func == (lhs: DailyStat, rhs: DailyStat) -> Bool {
        return lhs.date == rhs.date && lhs.length == rhs.length
    }
    
    static func < (lhs: DailyStat, rhs: DailyStat) -> Bool {
        return lhs.length < rhs.length
    }
}
