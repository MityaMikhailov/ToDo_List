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

    init(interface: TaskListViewProtocol, interactor: TaskListInteractorProtocol?, router: TaskListWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
