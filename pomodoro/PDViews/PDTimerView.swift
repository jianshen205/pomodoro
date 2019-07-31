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

        
//        progressView = PDProgressView(frame: .zero)
        self.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            progressView.topAnchor.constraint(equalTo: self.topAnchor),
//            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            progressView.leftAnchor.constraint(equalTo: self.leftAnchor),
//            progressView.rightAnchor.constraint(equalTo: self.rightAnchor),
            progressView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        self.addSubview(timeDisplay)//先add的view在底层
        self.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            timeDisplay.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeDisplay.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            //            timeDisplay.topAnchor.constraint(equalTo: self.topAnchor),
            //            timeDisplay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            //            timeDisplay.leftAnchor.constraint(equalTo: self.leftAnchor),
            //            timeDisplay.rightAnchor.constraint(equalTo: self.rightAnchor)
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
        
//        guard let customFont = UIFont(name: "HelveticaNeue", size: 100) else { fatalError("Font didn't load") }
        time.font = UIFont(name: time.font.fontName, size: 60)
        time.adjustsFontForContentSizeCategory = true
        
        time.text = "25:00"
        time.translatesAutoresizingMaskIntoConstraints = false //has to add this if we want auto layout
        return time
    }()
    

    
    func updateTimerView(timeChunk: PDTimeChunk){
        timeDisplay.text = Format.timeToString(timeChunk.timeRemaining)
        let progress: CGFloat = CGFloat(timeChunk.timeLength - timeChunk.timeRemaining)/CGFloat(timeChunk.timeLength)
        self.progressView.setProgress(value: progress)
        
    }
}
