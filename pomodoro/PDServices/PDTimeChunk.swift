//
//  PDTimeChunk.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation

struct PDTimeChunk {
    var type: PDTimeType!
    var timeLength: Int!
    var timeRemaining: Int!
}

enum PDTimeType {
    case work
    case shortBreak
    case LongBreak
}
