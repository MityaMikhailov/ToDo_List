//
//  TaskDetailViewController.swift
//  ToDo_List
//
//  Created Dmitriy Mikhailov on 02.09.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class TaskDetailViewController: UIViewController, TaskDetailViewProtocol {

	var presenter: TaskDetailPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }

}
