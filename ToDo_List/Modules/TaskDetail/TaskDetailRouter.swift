//
//  TaskDetailRouter.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class TaskDetailRouter: TaskDetailWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(task: Task?, id: Int16?) -> UIViewController {
        let view = TaskDetailViewController()
        let interactor = TaskDetailInteractor()
        let router = TaskDetailRouter()
        let presenter = TaskDetailPresenter(interface: view, interactor: interactor, router: router, task: task, id: id)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
