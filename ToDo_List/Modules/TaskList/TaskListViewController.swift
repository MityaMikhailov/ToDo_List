//
//  TaskListViewController.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class TaskListViewController: UIViewController, TaskListViewProtocol {

	var presenter: TaskListPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchData()
    }

    private func setupUI() {
        view.backgroundColor = .white
    }
    
    func updateTaskListTable() {
        
    }
    
}
