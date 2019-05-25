//
//  TodoItem.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import Foundation
struct TodoItem {
    var id: Int = 0
    var title:String = ""
    var description: String?
    var priority: String
    var date: String
    
    init(id:Int, title:String, description: String?, priority: String, date: String) {
        self.id = id
        self.title = title
        self.description = description
        self.priority = priority
        self.date = date
    }
}
