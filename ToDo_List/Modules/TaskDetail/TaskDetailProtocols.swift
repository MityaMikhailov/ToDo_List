//
//  TaskDetailProtocols.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

//MARK: Wireframe -
protocol TaskDetailWireframeProtocol: AnyObject {
    
}
//MARK: Presenter -
protocol TaskDetailPresenterProtocol: AnyObject {
    func getTask() -> Task?
    func getId() -> Int16?
    func updateTask(id: Int16, newName: String?, newDescription: String?, newStatus: Bool?, completion: @escaping() -> Void)
    func addTask(id: Int16, newName: String, newDescription: String, newStatus: Bool?, completion: @escaping() -> Void)
}

//MARK: Interactor -
protocol TaskDetailInteractorProtocol: AnyObject {
    
    var presenter: TaskDetailPresenterProtocol?  { get set }
    
    func saveResult(id: Int16, newName: String?, newDescription: String?, newStatus: Bool?, completion: @escaping() -> Void)
    func createTask(id: Int16, newName: String, newDescription: String, newStatus: Bool?, completion: @escaping () -> Void )
}

//MARK: View -
protocol TaskDetailViewProtocol: AnyObject {
    
    var presenter: TaskDetailPresenterProtocol?  { get set }
}
