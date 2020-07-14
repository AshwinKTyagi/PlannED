//
//  ViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 6/23/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit
import FSCalendar

class MainViewController: UIViewController{

    fileprivate weak var calendar: FSCalendar!
    let userData = UserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    func setUpNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

