//
//  TodoList.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

/*Class TodoList is a model that store todos as a list (array), the model includes some methods to manipulate todo data*/
import Foundation
import UIKit
class TodoList {
    static var todos: [TodoItem] = []    //array that store sources todo data
    static var sortedTodos: [TodoItem] = []  //array that store sorted todo
    static func addTodo(newTodo: TodoItem) {
        todos.append(newTodo)
    }
    /*deteTodo() is a method to delete todo from todo list by taking todo ID as input, each todo has an unique ID*/
    static func deleteTodo(todoID: UUID) {
        let index = todos.firstIndex(where: { $0.id == todoID })!
        todos.remove(at: index)
    }
    /* loadTodos() is the method that load todolist from UserDefault.standard. Because UserDefault.standard can not store customized object type. Instead of storing object, we are storing parameters that used to construct a object*/
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

   /*saveTodos() is a method to save todolist to local memory by using UserDefault.standard. Again, since UserDefault can not store customized object type, we store the parameters used to construct a object*/
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
    /*findTodo() is a method to find a todo by searching the todo id*/
    static func findTodo(todoID: UUID) -> TodoItem?{
        for todo in todos {
            if (todo.id == todoID){
                return todo
            }
        }
        return nil
    }
    /*sort todos according to their priority, from high to low*/
    static func SortByPriority() {
        sortedTodos = todos.sorted(by: { $0.reformatPriority().rawValue > $1.reformatPriority().rawValue})
    }
}
