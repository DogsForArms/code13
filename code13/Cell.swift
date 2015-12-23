//
//  Cell.swift
//  code13
//
//  Created by Ethan Sherr on 12/22/15.
//  Copyright © 2015 Ethan Sherr. All rights reserved.
//

import Foundation
import UIKit

class Cell : UITableViewCell
{
    var model:Int? {
        didSet {
            if let _ = model
            {
                label.text = "cell \(model!)"
            }
        }
    }
    var deleteBlock: (Void -> Void)?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteAction(sender: AnyObject) {
        self.deleteBlock?()
    }
    
    
}