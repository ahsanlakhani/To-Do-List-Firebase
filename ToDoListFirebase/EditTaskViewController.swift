//
//  EditTaskViewController.swift
//  ToDoListFirebase
//
//  Created by Ahsan Lakhani on 7/9/17.
//  Copyright © 2017 Ahsan Lakhani. All rights reserved.
//

import UIKit
import Firebase

class EditTaskViewController: UIViewController, UITextFieldDelegate {

    var list : ToDoModel?
    
    @IBOutlet weak var title_txt: UITextField!
    @IBOutlet weak var desc_txt: UITextView!
    @IBOutlet weak var date_datepicker: UIDatePicker!
    @IBOutlet weak var update_outlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title_txt.text = self.list?.title
        desc_txt.text = self.list?.desc
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        let date = dateFormatter.date(from: self.list!.duedate!)
        date_datepicker.date = date!
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func btn_update(_ sender: Any) {
        
        if(title_txt.text?.isEmpty)!{
            return
        }
        else if(desc_txt.text?.isEmpty)!{
            return
        }
        else{
            update_outlet.isEnabled = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            
            var ref : FIRDatabaseReference
            ref = FIRDatabase.database().reference().child((self.list?.id)!)
            
            let update = [
                "title" : title_txt.text!,
                "description" : desc_txt.text,
                "duedate" : dateFormatter.string(from: date_datepicker.date)
                ] as [String : Any]
            
            
            
            ref.updateChildValues(update, withCompletionBlock: { (error, ref) -> Void in
                if error != nil
                {
                    print(error!)
                }
                else
                {
                    self.update_outlet.isEnabled = true
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
}
