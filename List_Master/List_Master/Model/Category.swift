//
//  Category.swift
//  List_Master
//
//  Created by Qi Zhang on 27/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import Foundation

class Category {
    var title: String = ""
    var items = [TodoItem]()//Category contains todolist items
    var data = [Any]()//It contains a category title (the first item) and all the todolist items in it
    
    init(title:String){
        self.title=title
        self.data.append(title)
    }
    func getTitle()-> String{
        return title
    }
    
    func getItem() ->[TodoItem]{
        return items
    }
    
    func getData() ->[Any]{
        return data
    }
    
    func addItems(_ item: TodoItem){
        self.items.append(item)
        data.append(item)
    }
    
}
