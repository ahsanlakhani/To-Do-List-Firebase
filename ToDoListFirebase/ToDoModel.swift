//
//  ToDoModel.swift
//  ToDoListFirebase
//
//  Created by WASII on 10/07/2017.
//  Copyright © 2017 Ahsan Lakhani. All rights reserved.
//

import UIKit
class ToDoModel: NSObject {
    var title :String?
    var desc :String?
    var duedate: String?
    var id:String?
    
    init(title:String,desc:String,date:String, UId: String){
        self.title = title
        self.desc = desc
        self.duedate = date
        self.id = UId
    }
}
