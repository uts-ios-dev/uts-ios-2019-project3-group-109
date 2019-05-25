//
//  TodoList.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import Foundation
struct TodoList {
    static var todos: [TodoItem] = []
    static func addTodo(newTodo: TodoItem) {
        todos.append(newTodo)
    }
    static func deleteTodo(todo: TodoItem) {
        todos.remove(at: todo.id)
    }
    static func loadTodos() {
        guard let data = UserDefaults.standard.object(forKey: "todoItems") as? [[String: AnyObject]] else {
            return
        }
        todos = data.map {
            let id = $0["id"] as? Int
            let title = $0["title"] as? String
            let description = $0["description"] as? String
            let priority = $0["priority"] as? String
            let date = $0["date"] as? String
            
            return TodoItem(id: id!, title: title!, description: description!, priority: priority!, date: date!)
        }
    }
    static func saveTodos() {
        let data = todos.map {
            [
                "id": $0.id,
                "title": $0.title, 
                "description": $0.description!,
                "priority": $0.priority,
                "date": $0.date
            ]
        }
        UserDefaults.standard.set(data, forKey: "todoItems")
        UserDefaults.standard.synchronize()
    }
}
