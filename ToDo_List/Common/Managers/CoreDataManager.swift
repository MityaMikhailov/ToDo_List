//
//  CoreDataManager.swift
//  ToDo_List
//
//  Created by Dmitriy Mikhailov on 02.09.2024.
//

import UIKit
import CoreData

public final class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "ToDo_List")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    private lazy var managedContext: NSManagedObjectContext = {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = self.managedContext
        return moc
    }()
    
    //MARK: - CRUD (Create, Read, Update, Delete)
    
    public func createTask(id: Int16, taskName: String, taskDescription: String, executionStatus: Bool, dateCreate: Date, completion: @escaping () -> Void) {
        privateManagedObjectContext.perform { [weak self] in
            guard let taskEntityDescription = NSEntityDescription.entity(forEntityName: "Task", in: self!.privateManagedObjectContext) else { return }
            
            let task = Task(entity: taskEntityDescription, insertInto: self?.privateManagedObjectContext)
            task.taskId = id
            task.taskName = taskName
            task.taskDescription = taskDescription
            task.executionStatus = executionStatus
            task.dateCreate = dateCreate
            
            do {
                try self?.privateManagedObjectContext.save()
                self?.managedContext.performAndWait {
                    do {
                        try self?.managedContext.save()
                        completion()
                    } catch {
                        print("error")
                    }
                }
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    public func fetchTasks() -> [Task]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            let tasks = try managedContext.fetch(fetchRequest) as? [Task]
            let sortedTasks = tasks?.sorted(by: { $0.taskId < $1.taskId })
            return sortedTasks
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    public func fetchTask(with id: Int16) -> Task? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            let tasks = try? managedContext.fetch(fetchRequest) as? [Task]
            return tasks?.first(where: { $0.taskId == id })
        }
    }
    
    public func updateTask(with id: Int16, newName: String?, newDescription: String?, newStatus: Bool?, completion: @escaping () -> Void) {
        
        privateManagedObjectContext.perform { [weak self] in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            do {
                guard let tasks = try? self?.privateManagedObjectContext.fetch(fetchRequest) as? [Task],
                      let task = tasks.first(where: {$0.taskId == id}) else { return }
                
                task.taskName = newName ?? task.taskName
                task.taskDescription = newDescription ?? task.taskDescription
                task.executionStatus = newStatus ?? task.executionStatus
                
                try self?.privateManagedObjectContext.save()
                
                self?.managedContext.performAndWait {
                    do {
                        try self?.managedContext.save()
                        completion()
                    } catch {
                        print("error")
                    }
                }
            } catch {
                print("error")
            }
        }
    }
    
    public func deleteAllTasks(completion: @escaping () -> Void) {
        
        privateManagedObjectContext.perform { [weak self] in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            do {
                let tasks = try? self?.privateManagedObjectContext.fetch(fetchRequest) as? [Task]
                tasks?.forEach { self?.privateManagedObjectContext.delete($0) }
                
                try self?.privateManagedObjectContext.save()
                self?.managedContext.performAndWait {
                    do {
                        try self?.managedContext.save()
                        completion()
                    } catch {
                        print("error")
                    }
                }
            } catch {
                print("error")
            }
        }
    }
    
    public func deleteTask(with id: Int16, completion: @escaping () -> Void) {
        privateManagedObjectContext.perform { [weak self] in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            do {
                guard let tasks = try? self?.privateManagedObjectContext.fetch(fetchRequest) as? [Task],
                      let task = tasks.first(where: { $0.taskId == id }) else { return }
                self?.privateManagedObjectContext.delete(task)
                try self?.privateManagedObjectContext.save()
                
                self?.managedContext.performAndWait {
                    do {
                        try self?.managedContext.save()
                        completion()
                    } catch {
                        print("error")
                    }
                }
            } catch {
                print("error")
            }
        }
    }
    
}

