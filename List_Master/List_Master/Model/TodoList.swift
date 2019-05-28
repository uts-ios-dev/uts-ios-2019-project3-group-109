//
//  TodoList.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import Foundation
class TodoList {
    static var todos: [TodoItem] = []
    static var sortedTodos: [TodoItem] = []
    static func addTodo(newTodo: TodoItem) {
        todos.append(newTodo)
    }
    static func deleteTodo(todoID: UUID) {
        let index = todos.firstIndex(where: { $0.id == todoID })!
        todos.remove(at: index)
    }
    static func loadTodos() {
        guard let data = UserDefaults.standard.object(forKey: "todoItems") as? [[String: AnyObject]] else {
            return
        }
        todos = data.map {
            let id = $0["id"] as? String
            let title = $0["title"] as? String
            let description = $0["description"] as? String
            let priority = $0["priority"] as? String
            let date = $0["date"] as? String
            let completed = $0["completed"] as? Bool
            let todo = TodoItem(id: UUID(uuidString: id!)!, title: title!, description: description!, priority: priority!, date: date!)
            todo.completed = completed ?? false
            return todo
        }
    }
    
   
    static func saveTodos() {
        let data = todos.map {
            [
                "id": $0.id.uuidString,
                "title": $0.title, 
                "description": $0.description!,
                "priority": $0.priority,
                "date": $0.date,
                "completed": $0.completed
            ]
        }
        UserDefaults.standard.set(data, forKey: "todoItems")
        UserDefaults.standard.synchronize()
    }
    static func findTodo(todoID: UUID) -> TodoItem?{
        for todo in todos {
            if (todo.id == todoID){
                return todo
            }
        }
        return nil
    }
    static func SortByPriority() {
        sortedTodos = todos.sorted(by: { $0.reformatPriority().rawValue > $1.reformatPriority().rawValue})
    }
}
