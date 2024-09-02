//
//  TaskListRouter.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class TaskListRouter: TaskListWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = TaskListViewController()
        let interactor = TaskListInteractor()
        let router = TaskListRouter()
        let presenter = TaskListPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func pushToDetailTask(task: Task) {
        let vc = TaskDetailRouter.createModule(task: task, id: nil)
        self.viewController?.navigationController?.pushViewController(vc, animated: false)
    }
    
    func pushToNewTask(id: Int16) {
        let vc = TaskDetailRouter.createModule(task: nil, id: id)
        self.viewController?.navigationController?.pushViewController(vc, animated: false)
    }
}
