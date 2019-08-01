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
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")// what is adecoder, and why
        
    }
    
    /*
     set up origin view
     */
    func setupView() {
        self.navigationItem.title = "Timer"
        self.view.backgroundColor = .white
        
        todayGoal.text = String(format: "TODAY: %d / %d", self.persistanceService.fetchDailyGoal().completedSession, defaults.getDailyGoal())
        
        timerView = PDTimerView(frame: .zero)
        self.view.addSubview(timerView)
        timerView.timeDisplay.text = Format.timeToString(defaults.getWorkLength())
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
    
    /*
     initialize daily goals label
     */
    var todayGoal: UILabel = {
        let daily = UILabel(frame: .zero)
        daily.textColor = .orange
        daily.translatesAutoresizingMaskIntoConstraints = false
        return daily
    }()
    /*
     initialize pause/ resume button
     */
    var pauseResumeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("start", for: .normal)
        button.addTarget(self, action: #selector(pauseResume), for: .touchDown)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false;
        return button
    }()
    
    /*
     update progress view
     */
    func updateTimerProgress(timeChunk: PDTimeChunk) {
        timerView?.updateTimerView(timeChunk: timeChunk)
    }
    
    /*
     selector func when click on pause/resume button
     */
    @objc func pauseResume(){
        switch defaults.getSessionStatus() {
        case .ready:
            if self.timerService.timeChunks.isEmpty || self.timerService.timeChunks?[0].type == .work{
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
                        self.pauseResumeButton.setTitle("Pause", for: .normal)
                        self.defaults.setTimerStatus(.timing)
                        self.timerService.startTimer()
                        self.defaults.setSubject(value: subject.name!)
                    }))
                }
                subjectAction.addAction(UIAlertAction(title: "Add new subject", style: .default, handler:{(_) in self.addNewSubject()}))
                subjectAction.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                self.present(subjectAction, animated: true, completion: nil)
            }else{
                self.pauseResumeButton.setTitle("Pause", for: .normal)
                self.defaults.setTimerStatus(.timing)
                self.timerService.startTimer()
            }
        case .paused:
            pauseResumeButton.setTitle("Pause", for: .normal)
            defaults.setTimerStatus(.timing)
            timerService.startTimer()
        case .timing:
            pauseResumeButton.setTitle("Resume", for: .normal)
            defaults.setTimerStatus(.paused)
            timerService.stopTimer()
        }
        
    }
    /*
     helper func when adding new subject
    */
    func addNewSubject() {
        let addAction = UIAlertController(title: "add new subject", message: "enter the name of subject", preferredStyle: .alert)
        //weak alert, why?
        let submitAction = UIAlertAction(title: "submit", style: .default, handler:{[weak addAction](_) in
            self.persistanceService.saveSubject(name: (addAction?.textFields?[0].text!)!)
            })
        addAction.addAction(submitAction)
        addAction.addTextField(configurationHandler: nil)
        self.present(addAction, animated: true, completion: nil)
    }
    
}

extension PDTimerViewController: PDTimerServiceDelegate{
    
    func decrement(timeChunk: PDTimeChunk){
        updateTimerProgress(timeChunk: timeChunk)
    }
    
    func timeChunkComplete(timeChunk: PDTimeChunk) {
        defaults.setTimerStatus(.ready)
        pauseResumeButton.setTitle("Start", for: .normal)
        
        //setNextTimeChunk
        if timeChunk.type == .work{
            updateTimerProgress(timeChunk: self.timerService.timeChunks[0])
            self.timerView.progressView.trackLayer?.strokeColor = UIColor.green.cgColor
        }else{
            if self.timerService.timeChunks.isEmpty{
                updateTimerProgress(timeChunk: PDTimeChunk(type: PDTimeType.work, timeLength: self.defaults.getWorkLength(), timeRemaining: self.defaults.getWorkLength()))
            }
            else{
                updateTimerProgress(timeChunk: self.timerService.timeChunks[0])
            }
            self.timerView.progressView.trackLayer?.strokeColor = UIColor.orange.cgColor
            
            
        }
        //todo: update goals
        if timeChunk.type == .work{
            let goal = self.persistanceService.fetchDailyGoal()
            goal.completedSession += 1
            self.persistanceService.save()
        }
        //update goals after completion here
        todayGoal.text = String(format: "TODAY: %d / %d", self.persistanceService.fetchDailyGoal().completedSession, defaults.getDailyGoal())

    }
}
