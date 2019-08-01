//
//  PDPersistanceService.swift
//  pomodoro
//
//  Created by JianShen on 7/27/19.
//  Copyright © 2019 JianShen. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PDPersistanceService {
    let persistentContainer: NSPersistentContainer!
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext //这里的self需要在init之后，所以这个方程要在init之后，除非这个方程有keyword lazy
    }()
    
    convenience init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    func fetchDailyGoal() -> DailyGoal {
        let request: NSFetchRequest<DailyGoal> = DailyGoal.fetchRequest()//need to understand this
        
        let start = Calendar.current.startOfDay(for: Date())
        let end = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: start)
        request.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", argumentArray: [start, end!])
        
        guard let goal = try? persistentContainer.viewContext.fetch(request).first else { return createDailyGoal()! }
        return goal
        
    }
    func createDailyGoal() -> DailyGoal? {
        guard let goal = NSEntityDescription.insertNewObject(forEntityName: "DailyGoal", into: context) as? DailyGoal else { return nil }
        goal.date = Date()
        self.save()
        return goal
    }
    
    func saveSubject(name: String) -> Subject? {
        //guard?
         guard let subject = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: context) as? Subject else { return nil }
        subject.name = name
        self.save()
        return subject
    }
    
    //todo: didn't understand
    func fetchAllSubjects() -> [Subject] {
        let request: NSFetchRequest<Subject> = Subject.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request).sorted { $0.name! < $1.name! }
        return results ?? [Subject]()
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error \(error)") //what does it mean by \
            }
        }
    }
    func saveSession(seconds: Int, date: Date, subject: Subject) -> Session? {
        guard let session = NSEntityDescription.insertNewObject(forEntityName: "Session", into: context) as? Session else { return nil}
        session.length = Int64(seconds)
        session.date = date
        session.subject = subject
        
        subject.addToSession(session)
        self.save()
        return session
    }
    
    func fetchSessionsOfSubject(subject: Subject) -> [Session] {
        //todo:
        guard let sessions = subject.session?.allObjects as? [Session] else {
            assertionFailure("fail to fetch sessions of specific subject")
            return []
        }
        return sessions
    }
    
    func fetchAllSessions() -> [Session] {
        //todo:
        var sessions : [Session] = []
        self.fetchAllSubjects().forEach {
            guard let session = $0.session?.allObjects as? [Session] else {return}
            sessions.append(contentsOf: session)
        }
        return sessions
    }
    func fetchSubject(name: String) -> Subject? {
        let request: NSFetchRequest<Subject> = Subject.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        let res = ((try? persistentContainer.viewContext.fetch(request).first) as Subject??) // didn't understand
        return res ?? nil

    }
    //didn't understand
    func fetchSessionsDateRange(start: Date, end: Date) -> [Session] {
        let request: NSFetchRequest<Session> = Session.fetchRequest()
        request.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", argumentArray: [start, end])
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? []
    }
    

    //todo:
    func getSessionTimeOfSubject(subject:Subject) -> Int {
        let sessions: [Session] = self.fetchSessionsOfSubject(subject: subject)
        return Int(sessions.reduce(0) { $0 + $1.length })
    }
    //todo
    func getSessionsFromLastWeek() -> [DailyStat] {
        let lastWeek = self.getDatesForLastWeek()
        var summedData: [DailyStat] = Array()
        for date in lastWeek {
            let startDate = Calendar.current.startOfDay(for: date)
            let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startDate)!
            let sessions = fetchSessionsDateRange(start: startDate, end: endDate)
            summedData.append(DailyStat(date: endDate, length: Int(sessions.reduce(0) { $0 + $1.length })))
        }
        return summedData.reversed()
    }
    private func getDatesForLastWeek() -> [Date]{
        let now = Date()
        var dates = [now]
        for days in 1...6{
            //todo
            dates.append(Calendar.current.date(byAdding: .day, value: -days, to: now)!)
        }
        return dates
    }
    
    
}
