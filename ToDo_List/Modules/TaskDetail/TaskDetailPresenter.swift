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

}
