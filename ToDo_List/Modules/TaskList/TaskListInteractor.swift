//
//  TaskListInteractor.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class TaskListInteractor: TaskListInteractorProtocol {

    weak var presenter: TaskListPresenterProtocol?
    
    func fetchTasksList(completion: @escaping ([Task]) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let tasks = CoreDataManager.shared.fetchTasks(), tasks.count > 0 {
                completion(tasks)
            } else {
                self?.fetchTasksFromAPI { tasks in
                    completion(tasks)
                }
            }
        }
    }
    
    private func fetchTasksFromAPI(completion: @escaping([Task]) -> Void) {
        AlamofireManager.shared.fetchTasksList { result in
            switch result {
            case .success(let success):
                guard let tasksFromApi = success.todos else { completion([]); return }
                let dg = DispatchGroup()
                
                for task in tasksFromApi {
                    dg.enter()
                    guard let id = task.id,
                          let taskName = task.todo,
                          let executionStatus = task.completed else { return }
                    CoreDataManager.shared.createTask(
                        id: Int16(id),
                        taskName: taskName,
                        taskDescription: "",
                        executionStatus: executionStatus,
                        dateCreate: Date.now
                    ) {
                        dg.leave()
                    }
                }
                
                dg.notify(queue: .global()) {
                    if let tasks = CoreDataManager.shared.fetchTasks() {
                        DispatchQueue.main.async {
                            completion(tasks)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion([])
                        }
                    }
                }
                
            case .failure(let failure):
                print("Fail fetch from API: \(failure.localizedDescription)")
                completion([])
            }
        }
    }
    
    func removeElement(id: Int16, comp: @escaping() -> Void) {
        CoreDataManager.shared.deleteTask(with: id) {
            comp()
        }
    }
    
}
