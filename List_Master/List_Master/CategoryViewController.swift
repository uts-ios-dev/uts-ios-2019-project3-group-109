//
//  CategoryController.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import UIKit
import Foundation
class CategoryViewController: UIViewController {
    //现实category中每一个item的页面
    
    var cateName:String = ""
    
    
    let alertView:AlertSelectView = AlertSelectView.alertSelectView()
    
    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBAction func importBtnAction(_ sender: Any) {
        
        TodoList.loadTodos()
        
        CategoryImportTodoList.loadTodos(key: self.cateName)
        
        let tempArray:NSMutableArray = NSMutableArray.init()
        
        for item:TodoItem in TodoList.todos {
            var canAdd:Bool = true
            for yetItem:TodoItem in CategoryImportTodoList.todos {
                if yetItem.title == item.title && yetItem.priority == item.priority{
                    canAdd = false
                }
            }
            if canAdd{
                tempArray.add(item)
            }
        }
        
        self.alertView.showWithData(data: tempArray)
        self.alertView.blockproerty = { (selectItemArray) in
            self.dataArray.addObjects(from: selectItemArray as! [Any])
            for yetItem in selectItemArray {
                CategoryImportTodoList.addTodo(newTodo: yetItem as! TodoItem)
                CategoryImportTodoList.saveTodos(key: self.cateName)
            }
            self.contentTable.reloadData()
        }
    }
    
    @IBAction func editContent(_ sender: UIBarButtonItem) {
        self.contentTable.isEditing = !self.contentTable.isEditing
        if self.contentTable.isEditing == true {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    
    var items = [[TodoItem]]()
    var name : String = ""
    
    var dataArray:NSMutableArray = NSMutableArray.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTable.delegate = self
        contentTable.dataSource = self
        
        CategoryImportTodoList.loadTodos(key: self.cateName)
     
        if CategoryImportTodoList.todos.count != 0 {
            for item in CategoryImportTodoList.todos {
                self.dataArray.add(item)
            }
            self.contentTable.reloadData()
        }
    }
    
    
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        let item:TodoItem = self.dataArray.object(at: indexPath.row) as! TodoItem
        cell.todoTitle.text = item.title
        cell.todoPriority.text = item.priority
        
        //cell.detailTextLabel?.text = TodoList.todos[indexPath.row].priority
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //TodoList.todos.remove(at: indexPath.row)
        //listTable.reloadData()
        if (editingStyle == .delete) {
            
//            let item:TodoItem = self.dataArray.object(at: indexPath.row) as! TodoItem
            CategoryImportTodoList.todos.remove(at: indexPath.item)
            CategoryImportTodoList.saveTodos(key: self.cateName)
            
            self.dataArray.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item:TodoItem = self.dataArray.object(at: indexPath.row) as! TodoItem
        let detailVc:TodoDetailViewcontroller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TodoDetailViewcontroller") as! TodoDetailViewcontroller
        detailVc.todoId = item.id
        detailVc.todo = item
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}
