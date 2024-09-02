//
//  TaskDetailPresenter.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class TaskDetailPresenter: TaskDetailPresenterProtocol {

    weak private var view: TaskDetailViewProtocol?
    var interactor: TaskDetailInteractorProtocol?
    private let router: TaskDetailWireframeProtocol
    private let task: Task?
    private let id: Int16?

    init(interface: TaskDetailViewProtocol, interactor: TaskDetailInteractorProtocol?, router: TaskDetailWireframeProtocol, task: Task?, id: Int16?) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.task = task
        self.id = id
    }
    
    func getTask() -> Task? {
        return task
    }
    
    func getId() -> Int16? {
        return id
    }
    
    func updateTask(id: Int16, newName: String?, newDescription: String?, newStatus: Bool?, completion: @escaping () -> Void) {
        interactor?.saveResult(id: id, newName: newName, newDescription: newDescription, newStatus: newStatus) {
            completion()
        }
    }
    
    func addTask(id: Int16, newName: String, newDescription: String, newStatus: Bool?, completion: @escaping () -> Void) {
        interactor?.createTask(id: id, newName: newName, newDescription: newDescription, newStatus: newStatus) {
            completion()
        }
    }

}
