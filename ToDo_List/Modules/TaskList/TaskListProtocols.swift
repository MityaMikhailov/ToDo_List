//
//  TaskListProtocols.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol TaskListWireframeProtocol: AnyObject {
    func pushToDetailTask(task: Task)
    func pushToNewTask(id: Int16)
    
}
//MARK: Presenter -
protocol TaskListPresenterProtocol: AnyObject {
    func fetchData()
    func getTaskList() -> [Task]
    func deleteTask(id: Int16, completion: @escaping () -> Void)
    func createNewTask(id: Int16)
    func showDetailTask(task: Task)
}

//MARK: Interactor -
protocol TaskListInteractorProtocol: AnyObject {
    
    var presenter: TaskListPresenterProtocol?  { get set }
    func fetchTasksList(completion: @escaping ([Task]) -> Void)
    func removeElement(id: Int16, comp: @escaping() -> Void)
}

//MARK: View -
protocol TaskListViewProtocol: AnyObject {
    
    var presenter: TaskListPresenterProtocol?  { get set }
    func updateTaskListTable()
}
