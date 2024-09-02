//
//  TaskDetailInteractor.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class TaskDetailInteractor: TaskDetailInteractorProtocol {

    weak var presenter: TaskDetailPresenterProtocol?
    
    func saveResult(id: Int16, newName: String?, newDescription: String?, newStatus: Bool?, completion: @escaping() -> Void) {
        CoreDataManager.shared.updateTask(
            with: id,
            newName: newName,
            newDescription: newDescription,
            newStatus: newStatus ?? newStatus
        ) {
            completion()
        }
    }
    
    func createTask(id: Int16, newName: String, newDescription: String, newStatus: Bool?, completion: @escaping () -> Void) {
        CoreDataManager.shared.createTask(
            id: id,
            taskName: newName,
            taskDescription: newDescription,
            executionStatus: false,
            dateCreate: Date.now) {
                completion()
            }
    }
    
}
