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
    var completed: Bool
    
    init(id:UUID, title:String, description: String?, priority: String, date: String) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.priority = priority
        self.date = date
        self.completed = false
    }
}
