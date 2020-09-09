//
//  StartViewController.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 7/17/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import CoreData

class StartViewController: UIViewController{
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    let ref = Database.database().reference()
    
    let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        print("------------------Start------------------")
        
        
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                User.setEmail(email: value?["email"] as? String ?? "")
                User.setFirstName(firstName: value?["firstName"] as? String ?? "")
                User.setLastName(lastName: value?["lastName"] as? String ?? "")
                User.setTakenSATs(sats: value?["takenSATs"] as? [Any] ?? [])
                User.setTakenACTs(acts: value?["takenACTs"] as? [Any] ?? [])
                User.setChosenColleges(colleges: value?["chosenColleges"] as? [Any] ?? [])
                User.setEventDates(events: value?["finalEventDates"] as? [Any] ?? [])
              }) { (error) in
                print(error.localizedDescription)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:  {
                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
            })
        }
        
        if let localEventData = helper.readLocalJsonFile(forName: "eventData"){
            helper.parseForDates(eventJsonData: localEventData)
        }
        
        fetchCollegeData()
    }
    


    func fetchCollegeData() {
    //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
          appDelegate.persistentContainer.viewContext

        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "College")
        
        //3
        do {
            if let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]{
                Helper.colleges = results
                let formatter =  NumberFormatter()
                for result in results {
                    let ipsed = result.value(forKey: "ipsed") as? Int ?? 0
                    let name = result.value(forKey: "instName") as? String ?? ""
                    let alias = result.value(forKey: "alias") as? String ?? ""
                    Helper.collegeData.append(tempCollege.init(ipsed: formatter.string(from: ipsed as NSNumber) ?? "", name: name, alias: alias, reach: -1, checklist: [false, false, false, false, false, false]))
                    
                    Helper.collegeNameData.append(name)
                }
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if Helper.colleges.count == 0{
            Helper.saveCollegeToCoreData() /*This function puts a lot of strain on firebase so it should only be used once on app's first start-up*/
        }
        
    }

    @IBAction func onLoginClick(_ sender: Any){

        performSegue(withIdentifier: "startToLoginSegue", sender: sender)
    }

    @IBAction func onSignupClick(_ sender: Any){

        performSegue(withIdentifier: "startToSignupSegue", sender: sender)
    }

}


