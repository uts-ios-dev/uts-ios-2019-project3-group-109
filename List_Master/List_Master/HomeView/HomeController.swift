//
//  ViewController.swift
//  List_Master
//
//  Created by VencleDeng on 20/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.listTable.isEditing = !self.listTable.isEditing
        sender.title = (self.listTable.isEditing) ? "Done" : "Edit"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTable.delegate = self
        listTable.dataSource = self
        TodoList.loadTodos()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        TodoList.saveTodos()
        
        listTable.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDetail" {
             let destVC = segue.destination as! TodoDetailViewcontroller
            destVC.todoId = sender as? UUID
        }
       
    }


}
extension HomeController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObjectTemp = TodoList.todos[sourceIndexPath.item]
        TodoList.todos.remove(at: sourceIndexPath.item)
        TodoList.todos.insert(moveObjectTemp, at: destinationIndexPath.item)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoList.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        cell.todoTitle.text = TodoList.todos[indexPath.row].title
        cell.todoPriority.text = TodoList.todos[indexPath.row].priority
    
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            TodoList.deleteTodo(todoIndex: indexPath.item)
            TodoList.saveTodos()
            listTable.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let todo = TodoList.todos[indexPath.row]
        performSegue(withIdentifier: "HomeToDetail", sender: todo.id)
    }
    
}
