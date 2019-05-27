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
    
    @IBOutlet weak var contentTable: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func editContent(_ sender: UIBarButtonItem) {
        self.contentTable.isEditing = !self.contentTable.isEditing
        if self.contentTable.isEditing == true {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
}
