//
//  TodoItem.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import Foundation
class TodoItem {
    var id: UUID
    var title:String = ""
    var description: String?
    var priority: String
    var date: String
    var completed: Bool = false
    
    init(id:UUID, title:String, description: String?, priority: String, date: String) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.priority = priority
        self.date = date
       
    }
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
