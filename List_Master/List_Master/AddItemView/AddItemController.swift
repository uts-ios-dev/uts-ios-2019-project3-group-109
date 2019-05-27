//
//  AddItemController.swift
//  List_Master
//
//  Created by VencleDeng on 20/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//
import UIKit
import Foundation
class AddItemController: UIViewController{
    @IBOutlet weak var priorityPicker: UIPickerView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let priority = ["Low", "Medium", "High"]
    var selectedPriority:String = "Low"
    var selectedDate:String?
    
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        let title = titleText.text
        let description = descriptionText.text ?? ""
        let priority = selectedPriority
        let date = selectedDate!
        if (title == ""){
            let alert = UIAlertController(title: "Enter Todo title", message: "You must enter a title!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }else if (description == ""){
            let alert = UIAlertController(title: "Enter Todo description", message: "You must descript you todo!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let newItem: TodoItem = TodoItem(id: UUID(), title: title!, description: description, priority: priority, date: date)
            TodoList.addTodo(newTodo: newItem)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.priorityPicker.delegate = self
        self.priorityPicker.dataSource = self
        setUpPickers()
        setupTextView()
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    func setupTextView() {
        descriptionText.layer.borderColor = UIColor.gray.cgColor
        descriptionText.layer.borderWidth = 0.3
        descriptionText.layer.cornerRadius = 2.0
        descriptionText.clipsToBounds = true
    }
    func setUpPickers(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        selectedDate = formatter.string(from: datePicker.date)
        priorityPicker.selectedRow(inComponent: 0)
    }
    @IBAction func selectedDate(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        selectedDate = formatter.string(from: datePicker.date)
    }
}
extension AddItemController:UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priority[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priority.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = priority[row]
    }
}
