//
//  TableViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 6/29/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{

    var dayEventNames = [String]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func insertItems() {
        
    }
    
}
