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
        
        if let localEventData = helper.readLocalJsonFile(forName: "eventData"){
            helper.parseForDates(eventJsonData: localEventData)
        }
        
        print("------------------Start------------------")
        fetchCollegeData()
        if Helper.colleges.count == 0{
            Helper.saveCollegeToCoreData() /*This function puts a lot of strain on app so it should only be used once on app's first start-up*/
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        
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
                User.setChosenColleges(colleges: value?["chosenColleges"] as? [Any] ?? [] )
              }) { (error) in
                print(error.localizedDescription)
            }
            
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
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
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "College")
        
        //3
        do {
            Helper.colleges = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    @IBAction func onLoginClick(_ sender: Any){
        
        performSegue(withIdentifier: "startToLoginSegue", sender: sender)
    }
    
    @IBAction func onSignupClick(_ sender: Any){
        
        performSegue(withIdentifier: "startToSignupSegue", sender: sender)
    }
    
}


