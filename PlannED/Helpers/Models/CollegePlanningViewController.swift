//
//  CollegePlanningViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/14/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import UIKit
import SwiftUI

class CollegePlanningViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collegeSearchBar: UISearchBar!
        
    let userData = UserData()
    
    var searchActive : Bool = false
    var collegeNameData = [String]()
    var filtered = [String]()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collegeNameData = userData.getCollegeNames()
        
        configureCollegeSearchBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: configureCollegeSearchBar
    func configureCollegeSearchBar() {
        
        collegeSearchBar.delegate = self
        
        let textField = collegeSearchBar.searchTextField as UITextField
 
        textField.backgroundColor = .systemIndigo
        textField.textColor = .white
        
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.tintColor = .white
        
        let clearButton = textField.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = .white
        
        
    }

}

// MARK: EXTENSION W/ UITableViewDataSource, UITableViewDelegate, AND UISearchBarDelegate
extension CollegePlanningViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    //adds the correct amount of rows to the table
    // MARK: tableView: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive{
            return filtered.count
        }
        return collegeNameData.count
    }

    // MARK: tableView: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = UIColor.systemIndigo
        cell.textLabel?.textColor = UIColor.white
        
        if searchActive {
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = collegeNameData[indexPath.row]
        }
        
        return cell
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var i = Int()
        filtered = collegeNameData.filter({ (text) -> Bool in
            
            let tmp: NSString = text as NSString
            let tmpAlias = userData.getColleges()[i].getAlias() as NSString
            
                        
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let rangeAlias = tmpAlias.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
 
            i += 1
            return (range.location != NSNotFound || rangeAlias.location != NSNotFound)
        })
        
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
