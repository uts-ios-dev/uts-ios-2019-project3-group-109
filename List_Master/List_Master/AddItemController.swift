//
//  AddItemController.swift
//  List_Master
//
//  Created by VencleDeng on 20/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//
import UIKit
import Foundation
class AddItemController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var pickerView: UIPickerView!
    let priority = ["Low", "Medium", "High"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priority[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priority.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    }
