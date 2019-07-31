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
                print("Save error \(error)") //\what does it mean by \
            }
        }
    }

    
    
}
