//
//  AddTaskViewController.swift
//  ToDoListFirebase
//
//  Created by Ahsan Lakhani on 7/9/17.
//  Copyright © 2017 Ahsan Lakhani. All rights reserved.
//

import UIKit
import Firebase
class AddTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var title_txt: UITextField!
    @IBOutlet weak var desc_txt: UITextView!
    @IBOutlet weak var datepicker_date: UIDatePicker!
    @IBOutlet weak var insert_outlet: UINavigationItem!
    @IBOutlet weak var insert: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func submit_btn(_ sender: Any) {
        if(title_txt.text?.isEmpty)!{
            return
        }
        else if(desc_txt.text?.isEmpty)!{
            return
        }
        else{
            self.insert.isEnabled = false
            var ref : FIRDatabaseReference!
            ref = FIRDatabase.database().reference().childByAutoId()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            
            let task = [
                "title" : title_txt.text!,
                "description" : desc_txt.text!,
                "duedate" : dateFormatter.string(from: datepicker_date.date)
                ] as [String : Any]
            
            ref.updateChildValues(task, withCompletionBlock: { (error, ref) -> Void in
                if error != nil
                {
                    print(error!)
                }
                else
                {
                    self.insert.isEnabled = true
                    self.navigationController?.popViewController(animated: true)
                    
                }
            })
        }
    }
}
