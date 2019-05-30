//
//  CategoryViewController.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//
import UIKit
import Foundation


class CategoryListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var createCategory: UIBarButtonItem!
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var categoryList = [Category]()
    var nameContent = [String]()//The array of categories' names
    var itemContent = [[Any]]()//The array of categories' names and their items
    var tappedName : String = ""
    
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        self.categoryTable.isEditing = !self.categoryTable.isEditing
        if self.categoryTable.isEditing == true {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
            
        }
    //Tap edit to change the current editing situation

    }
    
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        var titleText = UITextField()
        let categorySet = UIAlertController(title:"Create New Category",message:"",preferredStyle:.alert)
        categorySet.addTextField { (setName) in
            titleText = setName
        }
        //After click the add button, show alert to require name of new category
        let action = UIAlertAction(title:"Add",style: .default){
            (action) in
        //Action after tap add button on alert
            if titleText.text != ""{
                let newCategory = Category(title:titleText.text!)
                self.categoryList.append(newCategory)
                if UserDefaults.standard.array(forKey: "CategoryName") != nil{
                    self.loadList()
                }
                self.nameContent.append(newCategory.getTitle())
                self.itemContent.append(newCategory.getData())
                //Extract stored items from userdefault (if any) to empty arrays and add new added item to these arrays
                self.saveList()
                self.categoryTable.reloadData()
                //After update the current category array, save data to userdefault and reload table data
            } else {
                let alert = UIAlertController(title:"Please enter category title",message:"",preferredStyle: .alert)
                let actionOk = UIAlertAction(title:"Ok", style:.default){
                    (actionOk) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(actionOk)
                self.present(alert,animated: true,completion: nil)
                //If input textfield is nil, show another alert controller minding user to tap non-nil input to category title
            }
           
        }
        categorySet.addAction(action)
        present(categorySet, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTable.delegate=self
        categoryTable.dataSource=self
        if UserDefaults.standard.array(forKey: "CategoryName") != nil {
            loadList()
            self.categoryTable.reloadData()
        }//如果userdefault中有数据，load数据并刷新表格
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "CategoryItemShow" {
            let target = segue.destination as? CategoryViewController
            //For any data to be transferred to next page
        }
    }
    func saveList(){
        UserDefaults.standard.removeObject(forKey: "CategoryName")
        UserDefaults.standard.removeObject(forKey: "CategoryItem")
        UserDefaults.standard.set(nameContent,forKey: "CategoryName")
        UserDefaults.standard.set(itemContent, forKey: "CategoryItem")
        UserDefaults.standard.synchronize()
        //Save all category name and items in them into two arrays, update and save entire array each time changes are made, when saving, first remove current array from userdefault and then store new array to userdefault
    }
    
    func loadList() {
        nameContent = UserDefaults.standard.array(forKey: "CategoryName") as! Array<String>//Category names
        itemContent = UserDefaults.standard.array(forKey: "CategoryItem") as! [[Any]]//Category name and items in it
    }
    //When loading data, extract usersdefault information and store to two arrays
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryViewCell
        let name = nameContent[indexPath.row]
        cells.categoryTitle.text = name
        return cells
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            nameContent.remove(at:indexPath.item)
            itemContent.remove(at:indexPath.item)
            saveList()
            categoryTable.deleteRows(at: [indexPath], with: .automatic)
            //When editing page using editing style tableview, remove item from two arrays then save data to userdefault
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            
        }
        
    }
}

