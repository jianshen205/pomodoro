//
//  Format.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation

class Format {
    static func timeToString(_ seconds:Int) -> String {
        let time = TimeInterval(exactly: seconds)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: time!) ?? ""
    }
}
