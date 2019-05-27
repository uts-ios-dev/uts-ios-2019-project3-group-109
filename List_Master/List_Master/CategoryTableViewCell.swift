//
//  CategoryTableViewCell.swift
//  List_Master
//
//  Created by Qi Zhang on 27/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
