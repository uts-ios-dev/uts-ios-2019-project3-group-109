//
//  ChosesCell.swift
//  List_Master
//
//  Created by Mr_Jesson on 2019/5/28.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import UIKit

class ChosesCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var leftLab: UILabel!
    @IBOutlet weak var rightLab: UILabel!//Priority:
    
    var isSelect:Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.leftImageView?.image = UIImage.init(named: "no_select")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func updateCellStatus() {
        if self.isSelect {
            self.leftImageView?.image = UIImage.init(named: "no_select")
            self.isSelect = false
        }else{
            self.leftImageView?.image = UIImage.init(named: "select")
            self.isSelect = true
        }
    }
    
}
