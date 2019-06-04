//
//  AlertWindow.swift
//  List_Master
//
//  Created by VencleDeng on 4/6/19.
//  Copyright © 2019 au.edu.uts. All rights reserved.
//

import Foundation
import UIKit
func alert(title: String,message: String, view: UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))           //ensure that field is not empty
    view.present(alert, animated: true, completion: nil)
}
