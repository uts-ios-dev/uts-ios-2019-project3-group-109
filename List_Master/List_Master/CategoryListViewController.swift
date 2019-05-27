//
//  CategoryViewController.swift
//  List_Master
//
//  Created by VencleDeng on 23/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//
import UIKit
import Foundation

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class CategoryListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var createCategory: UIBarButtonItem!
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var categoryList = [Category]()
    var nameContent = [String]()
    var itemContent = [[Any]]()
    var tappedName : String = ""
    
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        self.categoryTable.isEditing = !self.categoryTable.isEditing
        if self.categoryTable.isEditing == true {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
            
        }
            //点击edit切换被编辑页面状态

    }
    
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        var titleText = UITextField()
        let categorySet = UIAlertController(title:"Create New Category",message:"",preferredStyle:.alert)
        categorySet.addTextField { (setName) in
            titleText = setName
        }
        //在点击create后显示alert画面要求输入category名字并添加
        let action = UIAlertAction(title:"Add",style: .default){
            (action) in
            ///在点击加新的category之后的会做的action
            let newCategory = Category(title:titleText.text!)
            self.categoryList.append(newCategory)
            if UserDefaults.standard.array(forKey: "CategoryName") != nil{
                self.loadList()
            }
            self.nameContent.append(newCategory.getTitle())
            self.itemContent.append(newCategory.getData())
            //从原有userdefault中抽出已经存的data放进array中再添加新加的category进去变成更新后的全部category的array
            self.saveList()
            self.categoryTable.reloadData()
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
        //这里面是把已有category的名字单独存一个array，把category的名字和他们对应的item存在另一个array（为下个页面准备的，但感觉不太对），存userdefault的时候需要先删除原有信息再把更新过的array存进去
    }
    
    func loadList() {
        nameContent = UserDefaults.standard.array(forKey: "CategoryName") as! Array<String>
        itemContent = UserDefaults.standard.array(forKey: "CategoryItem") as! [[Any]]
    }
    //从userdefault中拖出已经存的array并存在variable中
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
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
            //编辑页面，被删除的category会被从array中删除
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            //可以return被点击的一行的indexpath.row，目前没有写东西
            
        }
        
    }
}

