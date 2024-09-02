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
    //MARK: - View DidLoad
	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: - View WillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchData()
    }
//MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemCyan
        navigationController?.navigationBar.backgroundColor = .clear
        title = "ToDo List"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.systemCyan
        ]
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.leftBarButtonItem = editButton
        
        setupTaskListTable()
    }
    //MARK: - Setup TaskList Table
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
//MARK: - Selectors
extension TaskListViewController {
    @objc private func addButtonTapped() {
        let taskId = presenter?.getTaskList().last?.taskId ?? 0
        let id = taskId + 1
        presenter?.createNewTask(id: id)
    }
    
    @objc private func editButtonTapped() {
        taskListTable.isEditing = true
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func doneButtonTapped() {
        taskListTable.isEditing = false
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let task = presenter?.getTaskList()[indexPath.row] else { return }
        presenter?.showDetailTask(task: task)
    }
    
    //MARK: - Delete Cell
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            guard let self = self,
                  let task = self.presenter?.getTaskList()[indexPath.row] else {
                completionHandler(false)
                return
            }
            let id = task.taskId
            
            self.presenter?.deleteTask(id: id) {
                tableView.deleteRows(at: [indexPath], with: .left)
                completionHandler(true)
            }
        }

        deleteAction.image = createDeleteActionImage()
        deleteAction.backgroundColor = .white
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    //MARK: - Create delete action image
    private func createDeleteActionImage() -> UIImage? {
        let deleteView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        deleteView.backgroundColor = .systemCyan
        deleteView.layer.cornerRadius = 30
        deleteView.clipsToBounds = true

        let trashImageView = UIImageView(image: UIImage(systemName: "trash"))
        trashImageView.tintColor = .white
        trashImageView.contentMode = .center
        trashImageView.frame = CGRect(x: 15, y: 15, width: 30, height: 30)
        
        deleteView.addSubview(trashImageView)

        UIGraphicsBeginImageContextWithOptions(deleteView.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        deleteView.layer.render(in: context)
        let actionImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return actionImage
    }
}
