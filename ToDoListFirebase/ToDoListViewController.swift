//
//  ToDoListViewController.swift
//  ToDoListFirebase
//
//  Created by Ahsan Lakhani on 7/9/17.
//  Copyright © 2017 Ahsan Lakhani. All rights reserved.
//

import UIKit
import Firebase

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list = [ToDoModel]()
    
    @IBOutlet weak var customTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchToDoList()
    }
    
    func FetchToDoList(){
        let ref = FIRDatabase.database().reference()
        ref.observe(.childAdded, with: { (snapshot) in
            if let todoDict = snapshot.value as? [String:AnyObject] {
                let title = todoDict["title"]
                let desc = todoDict["description"]
                let duedate = todoDict["duedate"]
                let key = snapshot.key
                
                let currentRow = ToDoModel(title: title as! String, desc: desc as! String, date: duedate as! String, UId: key as! String)
                
                self.list.append(currentRow)
                
            }
            self.customTable.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.observe(.childRemoved, with: {(snapshot) in
            let deleteKey = snapshot.key
            var toDeleteIndex = 0
            for i in 0..<self.list.count
            {
                if self.list[i].id == deleteKey
                {
                    toDeleteIndex = i
                }
            }
            self.list.remove(at: toDeleteIndex)
            self.customTable.reloadData()
        })
        
        ref.observe(.childChanged, with: {(snapshot) in
            let updateKey = snapshot.key
            if let todoList = snapshot.value as? [String:AnyObject] {
                let title = todoList["title"]
                let desc = todoList["description"]
                let duedate = todoList["duedate"]
                let key = snapshot.key
                
                let currentRow = ToDoModel(title: title as! String, desc: desc as! String, date: duedate as! String, UId: key as! String)
                
                var toUpdateIndex = 0
                for i in 0..<self.list.count
                {
                    if self.list[i].id == updateKey
                    {
                        toUpdateIndex = i
                    }
                }
                self.list[toUpdateIndex] = currentRow
                self.customTable.reloadData()
            }
        })
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let key = list[indexPath.row].id
            let ref = FIRDatabase.database().reference().child(key!)
            
            ref.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ToDoList"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TableViewCell
        
        cell.title_txt.text = list[indexPath.row].title
        cell.description_txt.text = list[indexPath.row].desc
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ETVC = self.storyboard!.instantiateViewController(withIdentifier: "ETViewController") as! EditTaskViewController
        
        ETVC.list = list[indexPath.row]
        self.navigationController?.pushViewController(ETVC, animated: true)
    }
    
    
}
