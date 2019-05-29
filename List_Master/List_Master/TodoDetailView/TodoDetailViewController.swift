//
//  TodoDetailView.swift
//  List_Master
//
//  Created by VencleDeng on 26/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

/*TodoDetailViewcontroller is the view controller for todo detail view*/
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
    var checkButtonSelected = false
    let priority = ["Low","Medium", "High"] //define a array of priority
    override func viewDidLoad() {
        super.viewDidLoad()
        todo = TodoList.findTodo(todoID: todoId!)
        setupPriorityField()
        setupDateField()
        initiate()
        
    }
    /*initiate() is a method that initiate the components' state in this view*/
    func initiate() {
        descriptionText.layer.borderColor = UIColor.gray.cgColor
        descriptionText.layer.borderWidth = 0.3
        descriptionText.layer.cornerRadius = 2.0
        descriptionText.clipsToBounds = true      //define the style of description text field
        viewMode()   //when user first enter to detail view all components should not be editable, unless 'Edit' button is clicked
        loadTodo()  //load details of the selected todo
        setupCheckButton()
    }
    /*viewMode() make all components non-editable*/
    func viewMode() {
        titleText.isUserInteractionEnabled = false
        descriptionText.isUserInteractionEnabled = false
        priorityText.isUserInteractionEnabled = false
        dateText.isUserInteractionEnabled = false
        checkButton.isUserInteractionEnabled = false
    }
    /*editMode() allow user to edit field such as title, description , etc*/
    func editMode() {
        titleText.isUserInteractionEnabled = true
        descriptionText.isUserInteractionEnabled = true
        priorityText.isUserInteractionEnabled = true
        dateText.isUserInteractionEnabled = true
        checkButton.isUserInteractionEnabled = true
    }
    /*setupCheckButton() set up a check button for todo completetion*/
    func setupCheckButton() {
        checkButton.setImage(UIImage(named: "Checkmarkempty"), for: .normal)
        checkButton.setImage(UIImage(named: "Checkmark"), for: .selected)
        if todo!.completed {
            checkButton.isSelected = true
        }else{
            checkButton.isSelected = false
        }
    }
    /*setupPriorityField() set up priority text field, when text field is clicked, a picker view is triggled instead of keyboard*/
    func setupPriorityField() {
        let priorityPicker = UIPickerView()
        priorityPicker.delegate = self
        priorityPicker.selectRow(0, inComponent: 0, animated: true)
        priorityText.inputView = priorityPicker
    }
    /*setupDateField() set up date text field, when text field is clicked, a picker view is triggled instead of keyboard*/
    func setupDateField() {
        let datePicker = UIDatePicker()
        dateText.inputView = datePicker
        datePicker.addTarget(self, action: #selector(TodoDetailViewcontroller.dateChanged(datePicker:)), for: .valueChanged)
    }
    /*dateChanged() handle the event generated when user change date through date picker, date of todo is changed accorddingly*/
    @objc func dateChanged(datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateText.text = formatter.string(from: datePicker.date)
        todo?.date = formatter.string(from: datePicker.date)
    }
    /*updateTodo()  update other two fields, title and description*/
    func updateTodo() {
        todo!.title = titleText.text ?? ""
        todo!.description = descriptionText.text ?? ""
        
    }
   /*editButtonTap() handle the event generated when user click on the edit button, when edit button is click, it changed to 'Done' button. User can edit fields after the 'edit' button is clicked. When 'Done button is clicked, updated todo will be saved to todo list.'*/
    @IBAction func editButtonTap(_ sender: UIBarButtonItem) {
        sender.title = sender.title == "Edit" ? "Done":"Edit"
        if sender.title == "Edit" {
           
            updateTodo()
            TodoList.saveTodos()
            viewMode()
        }else{
            editMode()
        }
    }
    /*checkButtonTap() handle click event on Check button, if the button is clicked, todo status is set to be completed. if the button is unclicked, todo status is set to be umcompleted*/
    @IBAction func checkButtonTap(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }  //set up button animation
        checkButtonSelected = !checkButtonSelected  // track the status of check button
        updateTodoStatus()
    }
    /*updateTodoStatus() is to update the status of todo (completed or uncompleted), associated with checkButtonTap() method*/
    func updateTodoStatus (){
        if checkButtonSelected {
            todo?.completed = true
        }else {
            todo?.completed = false
        }
    }
    /*load selected todo data*/
    func loadTodo() {
        if (todo != nil) {
            titleText.text = todo!.title
            descriptionText.text = todo!.description
            priorityText.text = todo!.priority
            dateText.text = todo!.date
        }
        
    }
}
/*The following extension is to define the attributed of priority picker view*/
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
