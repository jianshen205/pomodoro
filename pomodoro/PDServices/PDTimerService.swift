//
//  PDTimerService.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation

protocol PDTimerServiceDelegate: AnyObject {
    func decrement(timeChunk: PDTimeChunk)
    func sessionComplete(timeChunk: PDTimeChunk)
}

class PDTimerService {
    private var timer = Timer()
    weak var delegate: PDTimerServiceDelegate? // 为啥用weak，避免循环引用
    var timeChunk: PDTimeChunk!
    
    init( ) {
        self.timeChunk = buildTimeChunk() //you can't call methods on self before all non-optional instance variables are initialized. so it should be `var timeChunk: PDTimeChunk!`
        
    }

    func startTimer()  {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementTimer), userInfo: nil, repeats: true)
    }
    func pauseTimer(){
        timer.invalidate()
        
    }
    func buildTimeChunk() -> PDTimeChunk {
        let work = PDTimeChunk(type: PDTimeType.work, timeLength: 120, timeRemaining: 120)
        return work
        
    }
   @objc func decrementTimer() {
        timeChunk.timeRemaining -= 1
        delegate?.decrement(timeChunk: timeChunk)
        if(timeChunk.timeRemaining == 0){
            delegate?.sessionComplete(timeChunk: timeChunk)
        }
    }
}
