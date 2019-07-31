//
//  PDTimerViewController.swift
//  pomodoro
//
//  Created by JianShen on 7/24/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import UIKit

class PDTimerViewController: UIViewController{
    
    var timerView: PDTimerView!
    var progressView: PDProgressView!
    let timerService: PDTimerService!
    let defaults = PDDefaults()
    var persistanceService = PDPersistanceService()
    var subjects: [Subject] = []
    
    
    init(timerService: PDTimerService) {
        self.timerService = timerService
        super.init(nibName: nil, bundle: nil)
        
        timerService.delegate = self
        defaults.setTimerStatus(.ready)
//        self.persistanceService.saveSubject(name: "LeetCode")
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")// what is adecoder, and why
        
    }
    
    
    func setup() {
        self.navigationItem.title = "Timer"
        self.view.backgroundColor = .white
        
        timerView = PDTimerView(frame: .zero)
        self.view.addSubview(timerView)
        timerView.translatesAutoresizingMaskIntoConstraints = false;
        //auto layout
        NSLayoutConstraint.activate([
            timerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            timerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            timerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            timerView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor),
            timerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
       
        self.view.addSubview(pauseResumeButton)
        NSLayoutConstraint.activate([
            pauseResumeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pauseResumeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40)
            ])
        
        self.view.addSubview(todayGoal)
        NSLayoutConstraint.activate([
            todayGoal.topAnchor.constraint(equalTo: pauseResumeButton.bottomAnchor),
            todayGoal.centerXAnchor.constraint(equalTo: pauseResumeButton.centerXAnchor)
            
            ])

    }
    
    var todayGoal: UILabel = {
        let daily = UILabel(frame: .zero)
        daily.text = "Today's Goal"
        daily.textColor = .lightGray
        daily.translatesAutoresizingMaskIntoConstraints = false
        return daily
    }()
    
    var pauseResumeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("start", for: .normal)
        button.addTarget(self, action: #selector(pauseResume), for: .touchDown)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false;
        return button
    }()
    
    func updateTimer(timeChunk: PDTimeChunk) {
        timerView?.updateTimerView(timeChunk: timeChunk)
    }
    
    @objc func pauseResume(){
        
        switch defaults.getSessionStatus() {
        case .ready:
            NSLog("?call here")
            let subjectAction = UIAlertController(title: "what you want study for next session", message: "select subject", preferredStyle: .actionSheet)
            self.subjects = self.persistanceService.fetchAllSubjects()
            if let popoverController = subjectAction.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.subjects = persistanceService.fetchAllSubjects()
            subjects.forEach { subject in
                subjectAction.addAction(UIAlertAction(title: subject.name, style: .default, handler: { (_) in
                    //                    self.startSession(subjectName: subject.name!)
                }))
            }
            subjectAction.addAction(UIAlertAction(title: "Add new subject", style: .default, handler: nil))
            subjectAction.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(subjectAction, animated: true, completion: nil)
            
            pauseResumeButton.setTitle("Pause", for: .normal)
            defaults.setTimerStatus(.timing)
            timerService.startTimer()
        case .paused:
            pauseResumeButton.setTitle("Pause", for: .normal)
            defaults.setTimerStatus(.timing)
            timerService.startTimer()
        case .timing:
            pauseResumeButton.setTitle("Resume", for: .normal)
            defaults.setTimerStatus(.paused)
            timerService.pauseTimer()
        }
        
    }
}

extension PDTimerViewController: PDTimerServiceDelegate{
    
    func decrement(timeChunk: PDTimeChunk){
        updateTimer(timeChunk: timeChunk)
    }
    
    func sessionComplete(timeChunk: PDTimeChunk) {
        defaults.setTimerStatus(.ready)
        timerService.pauseTimer()
        pauseResumeButton.setTitle("Start", for: .normal)
        updateTimer(timeChunk: PDTimeChunk(type: PDTimeType.work, timeLength: 120, timeRemaining: 120))
        //todo: update goals
    }
}
