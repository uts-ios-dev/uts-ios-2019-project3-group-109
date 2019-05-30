//
//  CategoryViewCell.swift
//  List_Master
//
//  Created by Qi Zhang on 30/5/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var folderIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
