//
//  TodoItem.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

 /* TodoItem is a data model to store each individual todo*/
import Foundation
class TodoItem {
    var id: UUID             //each todo has a unique ID
    var title:String = ""
    var description: String?
    var priority: String
    var date: String
    var completed: Bool = false
    
    init(id:UUID, title:String, description: String?, priority: String, date: String){
        self.id = UUID()
        self.title = title
        self.description = description
        self.priority = priority
        self.date = date
       
    }
    /*reformatPriority() is a method that reformat todo's priority from String to a iterable Enum, which is useful in sorting todos based on priority*/
    func reformatPriority() ->Priority{
        switch priority {
        case "Low":
            return Priority.Low
        case "Medium":
            return Priority.Medium
        default:
            return Priority.High
        }
    }
}
