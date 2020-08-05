//
//  CollegePlanningViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/14/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//
import UIKit
import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

class CollegePlanningViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collegeSearchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let helper = Helper()
    
    let ref = Database.database().reference()
    
    var searchActive : Bool = false
    var collegeData = [tempCollege]()
    var collegeNameData = [String]()
    var filtered = [String]()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollegeSearchBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    // MARK: fetchData
    func fetchData() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute:  {
            
            self.ref.child("colleges").observeSingleEvent(of: .value, with: { (snapshot) in
                var i: Int = 0
                for child in snapshot.children  {
                    let snap = child as! DataSnapshot
                    let name = snap.childSnapshot(forPath: "INSTNM").value as? String ?? ""
                    let alias = snap.childSnapshot(forPath: "ALIAS").value as? String ?? ""
                    
                    self.collegeData.append(tempCollege.init(uid: snap.key, name: name, alias: alias))
                    self.collegeNameData.append(name)
                    
                    i += 1
                }
                print(i)
            }) { (error) in
                print(error.localizedDescription)
            }
        })
        tableView.reloadData()
        activityIndicator.stopAnimating()
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
        return collegeData.count
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
    
    
    // MARK: tableView: willDisplay
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
    // MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempCollegeName = filtered[indexPath.row]
        
        for c in collegeData {
            if tempCollegeName == c.name {
                Helper.tempCollegeID = c.uid
            }
        }
        
        performSegue(withIdentifier: "toCollege", sender: self)
    }
    
    // MARK: searchBarTextDidBeginEditing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    // MARK: searchBarTextDidEndEditing
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    // MARK: searchBarCancelButtonClicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    // MARK: searchBarTextDidBeginEditing
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    
    // MARK: searchBar: textDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var i = Int()
        filtered = collegeNameData.filter({ (text) -> Bool in
            
            let tmp: NSString = text as NSString
            let str: NSString = self.collegeData[i].alias as NSString
            let tmpAlias = str.components(separatedBy: "|")
            
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            var tmpBool = true
            for a in tmpAlias{
                let rangeAlias = (a as NSString).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                
                tmpBool = rangeAlias.location != NSNotFound
            }
            i += 1
            return (range.location != NSNotFound || tmpBool)
        })
        
        
        self.tableView.reloadData()
    }
    
    // MARK: didReceiveMemoryWarning()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: numberOfSectionsInTableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

