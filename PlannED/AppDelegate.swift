//
//  AppDelegate.swift
//  PlannED
//
//  Created by Ashwin Tyagi on 6/23/20.
//  Copyright © 2020 Ashwin Tyagi. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseDatabase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
//        addTestData()
        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "College")
//
//        do {
//            if let results = try persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
//                for result in results {
//                    if let ipsed = result.value(forKey: "ipsed") as? Int, let instName = result.value(forKey: "instName") as? String {
//                        print("\(ipsed), \(instName)")
//                    }
//                }
//            }
//        } catch {
//            print("There was a fetch error")
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        User.saveDataToFirebase()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
      let container = NSPersistentContainer(name: "PlannED")
     container.loadPersistentStores(completionHandler: { (storeDescription, error) in
     if let error = error as NSError? {
     // Replace this implementation with code to handle the error appropriately.
     // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although     it may be useful during development.
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
    Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
        }
     })
        return container
    }()
    

    func addTestData() {
        guard let entity = NSEntityDescription.entity(forEntityName: "College", in: persistentContainer.viewContext) else {
            fatalError("Could not find entity description!")
        }
        
        var rng = SystemRandomNumberGenerator()
        
        for i in 1...25 {
            let device = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
            device.setValue(i, forKey: "ipsed")
            device.setValue("collegeName\(rng.next())", forKey: "instName")
        }
    }
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
}
