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
        self.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100)
            ])
        
        self.addSubview(timeDisplay)
        self.backgroundColor = .clear
        NSLayoutConstraint.activate([
            timeDisplay.topAnchor.constraint(equalTo: self.topAnchor),
            timeDisplay.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            timeDisplay.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),

            ])

        
    }
    var progressView: PDProgressView = {
        let progress = PDProgressView(frame: .zero)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    
    var timeDisplay: UILabel = {
        let time = UILabel(frame: .zero)
        time.textColor = UIColor.orange
        time.textAlignment = .center
        
        time.font = UIFont(name: time.font.fontName, size: 60)
        time.adjustsFontForContentSizeCategory = true
        
        time.translatesAutoresizingMaskIntoConstraints = false //has to add this if we want auto layout
        return time
    }()
    

    
    func updateTimerView(timeChunk: PDTimeChunk){
        timeDisplay.text = Format.timeToString(timeChunk.timeRemaining)
        let progress: CGFloat = CGFloat(timeChunk.timeLength - timeChunk.timeRemaining)/CGFloat(timeChunk.timeLength)
        self.progressView.setProgress(value: progress)
        
    }
}
