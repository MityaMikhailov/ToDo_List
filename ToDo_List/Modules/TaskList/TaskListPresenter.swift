//
//  TaskListPresenter.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class TaskListPresenter: TaskListPresenterProtocol {

    weak private var view: TaskListViewProtocol?
    var interactor: TaskListInteractorProtocol?
    private let router: TaskListWireframeProtocol
    
    private var tasksList: [Task]?

    init(interface: TaskListViewProtocol, interactor: TaskListInteractorProtocol?, router: TaskListWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func fetchData() {
        interactor?.fetchTasksList{ [weak self] tasks in
            DispatchQueue.main.async {
                self?.tasksList = tasks
                self?.view?.updateTaskListTable()
            }
        }
    }
    
    func getTaskList() -> [Task] {
        guard let tasksList else { return [] }
        return tasksList
    }
    
    func deleteTask(id: Int16, completion: @escaping () -> Void) {
        self.tasksList?.removeAll { $0.taskId == id }
        interactor?.removeElement(id: id) {
            completion()
        }
        
    }
    
    func createNewTask(id: Int16) {
        router.pushToNewTask(id: id)
    }
    
    func showDetailTask(task: Task) {
        router.pushToDetailTask(task: task)
    }
    
}
