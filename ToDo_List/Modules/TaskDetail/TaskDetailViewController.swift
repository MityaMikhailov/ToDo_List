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
    
    private lazy var nameTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите имя задачи"
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите описание задачи"
        label.textColor = .black
        return label
    }()
    
    private lazy var nameTaskTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemCyan
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .white
        textView.returnKeyType = .done
        textView.delegate = self
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemCyan
        textView.font = .systemFont(ofSize: 20)
        textView.textColor = .white
        textView.returnKeyType = .done
        textView.delegate = self
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemCyan
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Выберите статус задачи"
        label.textColor = .black
        return label
    }()
    
    private lazy var statusControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Не выполнена", "Выполнена"])
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var statusStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(statusText)
        stack.addArrangedSubview(statusControl)
        return stack
    }()
    
    var executionStatus: Bool?
    //MARK: - View Did Load
	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: - Setup UI
    private func setupUI() {
        
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .white
        title = "Create task"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.systemCyan
        ]
        
        if let task = presenter?.getTask() {
            nameTaskTextView.text = task.taskName
            descriptionTextView.text = task.taskDescription
            title = "Update task"
        }
        
        if let taskexecutionStatus = presenter?.getTask()?.executionStatus {
            statusControl.selectedSegmentIndex = taskexecutionStatus ? 1 : 0
        }
        statusControl.selectedSegmentTintColor = statusControl.selectedSegmentIndex == 0 ? .red : .green
        
        view.addSubview(nameTaskLabel)
        view.addSubview(nameTaskTextView)
        view.addSubview(descriptionTaskLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(statusStack)
        view.addSubview(saveButton)
        
        nameTaskLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        nameTaskTextView.snp.makeConstraints {
            $0.top.equalTo(nameTaskLabel.snp.bottom)
            $0.height.equalTo(50)
            $0.left.right.equalToSuperview()
        }
        
        descriptionTaskLabel.snp.makeConstraints {
            $0.top.equalTo(nameTaskTextView.snp.bottom).offset(30)
            $0.left.right.equalToSuperview()
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionTaskLabel.snp.bottom)
            $0.height.equalTo(100)
            $0.left.right.equalToSuperview()
        }
        
        statusControl.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.width.equalToSuperview()
        }
        
        statusStack.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalTo(80)
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(saveButton.snp.width).multipliedBy(0.2)
        }
        
    }

}

//MARK: - Selectors
extension TaskDetailViewController {
    
    @objc private func saveButtonClicked() {
        
        if nameTaskTextView.text.isEmpty && descriptionTextView.text.isEmpty {
            self.navigationController?.popViewController(animated: false)
        } else {
            if let id = presenter?.getTask()?.taskId {
                let newName = nameTaskTextView.text
                let newDescription = descriptionTextView.text
                presenter?.updateTask(id: id, newName: newName, newDescription: newDescription, newStatus: executionStatus) { [weak self] in
                    self?.navigationController?.popViewController(animated: false)
                }
            } else {
                guard let id = presenter?.getId() else { return }
                let newName = nameTaskTextView.text ?? ""
                let newDescription = descriptionTextView.text ?? ""
                presenter?.addTask(id: id, newName: newName, newDescription: newDescription, newStatus: executionStatus) { [weak self] in
                    self?.navigationController?.popViewController(animated: false)
                }
            }
        }
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sender.selectedSegmentTintColor = .red
            executionStatus = false
        case 1:
            sender.selectedSegmentTintColor = .green
            executionStatus = true
        default:
            break
        }
    }
}
//MARK: - UITextViewDelegate
extension TaskDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
