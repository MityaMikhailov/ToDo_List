//
//  TaskListAPI.swift
//  ToDo_List
//
//  Created by Dmitriy Mikhailov on 02.09.2024.
//

import Foundation

// MARK: - TaskListAPI
struct TaskListAPI: Codable {
    let todos: [Todo]?
    let total, skip, limit: Int?
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int?
    let todo: String?
    let completed: Bool?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
}
