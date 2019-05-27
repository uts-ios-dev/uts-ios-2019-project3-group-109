//
//  TodoDetailView.swift
//  List_Master
//
//  Created by VencleDeng on 26/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import UIKit
import Foundation
class TodoDetailViewcontroller: UIViewController{
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var priorityText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var todoId: UUID?
    var todo: TodoItem?
    let priority = ["Low","Medium", "High"]
    override func viewDidLoad() {
        super.viewDidLoad()
        todo = TodoList.findTodo(todoID: todoId!)
        setupPriorityField()
        setupDateField()
        initiate()
        
    }
    
    func initiate() {
        descriptionText.layer.borderColor = UIColor.gray.cgColor
        descriptionText.layer.borderWidth = 0.3
        descriptionText.layer.cornerRadius = 2.0
        descriptionText.clipsToBounds = true
        viewMode()
        loadTodo()
        setupCheckButton()
    }
    func viewMode() {
        titleText.isUserInteractionEnabled = false
        descriptionText.isUserInteractionEnabled = false
        priorityText.isUserInteractionEnabled = false
        dateText.isUserInteractionEnabled = false
    }
    func editMode() {
        titleText.isUserInteractionEnabled = true
        descriptionText.isUserInteractionEnabled = true
        priorityText.isUserInteractionEnabled = true
        dateText.isUserInteractionEnabled = true
    }
    func setupCheckButton() {
        checkButton.setImage(UIImage(named: "Checkmarkempty"), for: .normal)
        checkButton.setImage(UIImage(named: "Checkmark"), for: .selected)
    }
    func setupPriorityField() {
        let priorityPicker = UIPickerView()
        priorityPicker.delegate = self
        priorityPicker.selectRow(0, inComponent: 0, animated: true)
        priorityText.inputView = priorityPicker
    }
    func setupDateField() {
        let datePicker = UIDatePicker()
        dateText.inputView = datePicker
        datePicker.addTarget(self, action: #selector(TodoDetailViewcontroller.dateChanged(datePicker:)), for: .valueChanged)
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateText.text = formatter.string(from: datePicker.date)
        todo?.date = formatter.string(from: datePicker.date)
    }
    func updateTodo() {
        todo!.title = titleText.text ?? ""
        todo!.description = descriptionText.text ?? ""
        
    }
   
    @IBAction func editButtonTap(_ sender: UIBarButtonItem) {
        sender.title = sender.title == "Edit" ? "Done":"Edit"
        if sender.title == "Edit" {
           
            updateTodo()
            viewMode()
            print(String(TodoList.findTodo(todoID: todoId!)?.priority ?? ""))
            print(String(TodoList.findTodo(todoID: todoId!)?.date ?? ""))
        }else{
            editMode()
        }
    }
    
    @IBAction func checkButtonTap(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        
        
        
    }
    
    func loadTodo() {
        if (todo != nil) {
            titleText.text = todo!.title
            descriptionText.text = todo!.description
            priorityText.text = todo!.priority
            dateText.text = todo!.date
        }
        
    }
}
extension TodoDetailViewcontroller: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priority.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priority[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        todo?.priority = priority[row]
        priorityText.text = priority[row]
    }
}
