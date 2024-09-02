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
    let taskListTable = UITableView()

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
        navigationController?.navigationBar.tintColor = .systemCyan
        navigationController?.navigationBar.backgroundColor = .clear
        title = "ToDo List"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.systemCyan
        ]
        
        setupTaskListTable()
    }
    
    private func setupTaskListTable() {
        taskListTable.isEditing = false
        taskListTable.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        taskListTable.dataSource = self
        taskListTable.delegate = self
        taskListTable.backgroundColor = .clear
        taskListTable.separatorStyle = .none
        taskListTable.sectionIndexTrackingBackgroundColor = .red
        view.addSubview(taskListTable)
        
        taskListTable.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.left.right.equalToSuperview()
        }
    }
    
    func updateTaskListTable() {
        taskListTable.reloadData()
    }
    
}

//MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getTaskList().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as? TaskCell,
              let task = presenter?.getTaskList()[indexPath.row] else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(with: task)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension TaskListViewController: UITableViewDelegate {
    
}
