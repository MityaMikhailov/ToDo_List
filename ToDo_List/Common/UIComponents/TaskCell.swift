//
//  TaskCell.swift
//  ToDo_List
//
//  Created by Dmitriy Mikhailov on 02.09.2024.
//

import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    private lazy var nameTaskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var descriptionTaskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var dateTaskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var statusTaskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var dateStatusStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(dateTaskLabel)
        stack.addArrangedSubview(statusTaskLabel)
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        
        let taskCellView = UIView()
        
        taskCellView.addSubview(nameTaskLabel)
        taskCellView.addSubview(descriptionTaskLabel)
        taskCellView.addSubview(dateStatusStack)
        
        nameTaskLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(10)
            $0.height.greaterThanOrEqualTo(50)
        }
        
        descriptionTaskLabel.snp.makeConstraints {
            $0.top.equalTo(nameTaskLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview()
        }
        
        dateStatusStack.snp.makeConstraints {
            $0.top.equalTo(descriptionTaskLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(taskCellView)
        
        taskCellView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5).priority(999)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(10).priority(999)
        }
        
        taskCellView.layer.cornerRadius = 15
        taskCellView.backgroundColor = .systemCyan
        contentView.backgroundColor = .clear
        
        
    }
    
    public func configure(with task: Task) {
        nameTaskLabel.text = task.taskName
        descriptionTaskLabel.text = task.taskDescription.isEmpty ? "No description text" : task.taskDescription
        dateTaskLabel.text = task.dateCreate.formatted()
        statusTaskLabel.text = task.executionStatus ? "Выполнена" : "Не выполнена"
        statusTaskLabel.textColor = task.executionStatus ? .systemGreen : .red
    }
    
}

