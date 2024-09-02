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
    
}

//MARK: Interactor -
protocol TaskDetailInteractorProtocol: AnyObject {
    
    var presenter: TaskDetailPresenterProtocol?  { get set }
}

//MARK: View -
protocol TaskDetailViewProtocol: AnyObject {
    
    var presenter: TaskDetailPresenterProtocol?  { get set }
}
