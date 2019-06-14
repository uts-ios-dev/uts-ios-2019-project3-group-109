//
//  AlertSelectView.swift
//  List_Master
//
//  Created by Mr_Jesson on 2019/5/28.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import UIKit

class AlertSelectView: UIView {
    
    var data:NSArray?
    
    var selectArray:NSMutableArray = NSMutableArray.init()
    
    typealias sureBtnClickBlock = (_ selectItemArray :NSMutableArray) ->()
    var blockproerty:sureBtnClickBlock!
    

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss()
    }
    @IBAction func sureBtnAction(_ sender: Any) {
        if blockproerty != nil {
            blockproerty(self.selectArray)
            self.dismiss()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 5
        self.tag = 888
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib.init(nibName: "ChosesCell", bundle: nil), forCellReuseIdentifier: "ChosesCell")
        self.mainTableView.rowHeight = 40
        
    }
    
    static func alertSelectView() -> AlertSelectView {
        return Bundle.main.loadNibNamed("AlertSelectView", owner: nil, options: nil)?.last as! AlertSelectView
    }
    
    func showWithData(data:NSArray) -> Void {
        self.data = data
        let delegate  = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.addSubview(self)
        self.mainTableView.reloadData()
    }
    
    func dismiss() -> Void {
        self.selectArray.removeAllObjects()
        let delegate  = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.viewWithTag(888)?.removeFromSuperview()
    }

}

extension AlertSelectView: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0{
            return 10
        }else{
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChosesCell = tableView.dequeueReusableCell(withIdentifier: "ChosesCell", for: indexPath) as! ChosesCell
        let item:TodoItem = self.data?.object(at: indexPath.section) as! TodoItem
        cell.leftLab.text = item.title;
        cell.rightLab.text = "Priority:"+item.priority
        cell.isSelect = false
        cell.leftImageView.image = UIImage.init(named: "no_select")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:ChosesCell = tableView.cellForRow(at: indexPath) as! ChosesCell
        let item:TodoItem = self.data?.object(at: indexPath.section) as! TodoItem
        
        cell.updateCellStatus()
        if cell.isSelect {
            self.selectArray.add(item)
        }else{
            for (index,value) in self.selectArray.enumerated() {
                let yetItem:TodoItem = value as! TodoItem
                if yetItem.title == item.title && yetItem.priority == item.priority{
                    self.selectArray.removeObject(at: index)
                }
            }
            
        }
    }
    
}
