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
    
}
//MARK: Presenter -
protocol TaskListPresenterProtocol: AnyObject {
    
}

//MARK: Interactor -
protocol TaskListInteractorProtocol: AnyObject {
    
    var presenter: TaskListPresenterProtocol?  { get set }
}

//MARK: View -
protocol TaskListViewProtocol: AnyObject {
    
    var presenter: TaskListPresenterProtocol?  { get set }
}
