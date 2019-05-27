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
    var items = [TodoItem]()//category包含的todolist item
    var data = [Any]()//里面包含一个category的title（第一位）和里面的所有todolist items
    
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
