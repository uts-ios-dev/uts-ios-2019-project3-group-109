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
    
    /*let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
    
    
    @objc
    func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = editButton
        
        listTable.setEditing(false, animated: true)
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        guard !TodoList.todos.isEmpty else {
            return
        }
        self.navigationItem.leftBarButtonItem = doneButton
        listTable.setEditing(true, animated: true)
    }*/
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.listTable.isEditing = !self.listTable.isEditing
        sender.title = (self.listTable.isEditing) ? "Done" : "Edit"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTable.delegate = self
        listTable.dataSource = self
        TodoList.loadTodos()
        //doneButton.style = .plain
        //doneButton.target = self
    }
    override func viewDidAppear(_ animated: Bool) {
        TodoList.saveTodos()
        
        listTable.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
        //cell.detailTextLabel?.text = TodoList.todos[indexPath.row].priority
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //TodoList.todos.remove(at: indexPath.row)
        //listTable.reloadData()
        if (editingStyle == .delete) {
            TodoList.todos.remove(at: indexPath.item)
            listTable.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
