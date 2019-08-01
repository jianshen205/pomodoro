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
    func timeChunkComplete(timeChunk: PDTimeChunk)
}

class PDTimerService {
    
    private var timer = Timer()
    var defaults = PDDefaults()
    weak var delegate: PDTimerServiceDelegate? // 为啥用weak，避免循环引用
    var timeChunks: [PDTimeChunk]!
    var persistanceService = PDPersistanceService()
    
    let numberOfSessionsBeforeLongBreak = 4
    
    init() {
        self.timeChunks = buildTimeChunkArray() //you can't call methods on self before all non-optional instance variables are initialized. so it should be `var timeChunk: PDTimeChunk!`
    }

    func startTimer()  {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementTimer), userInfo: nil, repeats: true)
    }
    func stopTimer(){
        timer.invalidate()
        
    }
    func buildTimeChunkArray() -> [PDTimeChunk] {
        var arr : [PDTimeChunk] = Array()
        let work = PDTimeChunk(type: PDTimeType.work, timeLength: defaults.getWorkLength(), timeRemaining: defaults.getWorkLength())
        let shorBreak = PDTimeChunk(type: .shortBreak, timeLength: defaults.getShortBreak(), timeRemaining: defaults.getShortBreak())
        let longBreak = PDTimeChunk(type: .LongBreak, timeLength: defaults.getLongBreak(), timeRemaining: defaults.getLongBreak())
        
        for session in 1...defaults.getDailyGoal() {
            arr.append(work)
            arr.append( session % numberOfSessionsBeforeLongBreak == 0 ? longBreak:shorBreak)
        }
        return arr
        
    }
   @objc func decrementTimer() {
        timeChunks?[0].timeRemaining -= 1
        delegate?.decrement(timeChunk: timeChunks.first!)
        if(timeChunks.first!.timeRemaining == 0){
            stopTimer()
            saveProgress(timeChunk: timeChunks.first!)
            delegate?.timeChunkComplete(timeChunk: timeChunks.removeFirst())
            
            
        }
    }
    
    //save finished timechunk to persistanceService
    private func saveProgress(timeChunk: PDTimeChunk){
        if timeChunk.type == .work {
            var name = self.defaults.getSubjectName()
            guard let subject = self.persistanceService.fetchSubject(name: name) else { return }
            let time = timeChunks.first!.timeRemaining == 0 ? timeChunk.timeLength : (timeChunk.timeLength - timeChunk.timeRemaining)
            _ = persistanceService.saveSession(seconds: time!, date: Date(), subject: subject)
            
        }
    }
}
