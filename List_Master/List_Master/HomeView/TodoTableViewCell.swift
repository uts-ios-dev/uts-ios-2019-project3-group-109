//
//  TodoTableViewCell.swift
//  List_Master
//
//  Created by VencleDeng on 25/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoPriority: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
