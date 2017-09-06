//
//  TableViewCell.swift
//  ToDoListFirebase
//
//  Created by WASII on 10/07/2017.
//  Copyright © 2017 Ahsan Lakhani. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var title_txt : UILabel!
    @IBOutlet weak var description_txt : UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
