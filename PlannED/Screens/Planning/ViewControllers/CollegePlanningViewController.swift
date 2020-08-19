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
    var filtered = [String]()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollegeSearchBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if Helper.collegeNameData.count == 0 {
            fetchData()
        }
    }
    
    // MARK: fetchData
    func fetchData() {
        activityIndicator.startAnimating()
        collegeSearchBar.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute:  {
            
            self.ref.child("colleges").observeSingleEvent(of: .value, with: { (snapshot) in
                var i: Int = 0
                for child in snapshot.children  {
                    let snap = child as! DataSnapshot
                    let name = snap.childSnapshot(forPath: "INSTNM").value as? String ?? ""
                    let alias = snap.childSnapshot(forPath: "ALIAS").value as? String ?? ""
                    
                    Helper.collegeData.append(tempCollege.init(ipsed: snap.key, name: name, alias: alias))
                    Helper.collegeNameData.append(name)
                    
                    i += 1
                }
                print(i)
                self.activityIndicator.stopAnimating()
                self.collegeSearchBar.isHidden = false
            }) { (error) in
                print(error.localizedDescription)
            }
        })
        tableView.reloadData()
    }
    
    // MARK: configureCollegeSearchBar
    func configureCollegeSearchBar() {
        
        collegeSearchBar.delegate = self
        
        let textField = collegeSearchBar.searchTextField as UITextField
 
        textField.backgroundColor = UIColor(red: 150/255, green: 1/255, blue: 190/255, alpha: 1)
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
        return Helper.collegeData.count
    }

    // MARK: tableView: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let frame = tableView.frame
        
        cell.textLabel?.textColor = UIColor.white
        
        if searchActive {
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = Helper.collegeNameData[indexPath.row]
        }
        
        let topSeperatorLineView = UIView(frame: CGRect(x: 10, y: 0, width: frame.width - 20, height: 0.5))
        topSeperatorLineView.backgroundColor = .white
        
        if indexPath.row != 0 {
            cell.addSubview(topSeperatorLineView)
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
        
        for c in Helper.collegeData {
            if tempCollegeName == c.name {
                Helper.temporaryCollege = c
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
        filtered = Helper.collegeNameData.filter({ (text) -> Bool in
            
            let tmp: NSString = text as NSString
            let str: NSString = Helper.collegeData[i].alias as NSString
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

