//
//  CoreDataManager.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 15.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//
import UIKit
import CoreData
class CoreDataManager:NSObject {
    private class func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    class func saveObject(reposUrl: String, userName: String, watchCount: Int16, starCount: Int16, forkCount: Int16, reposName: String){
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {

                let context = getContext()
                let entity = NSEntityDescription.entity(forEntityName: "FavoritesRepositories", in: context)
                let manageObject = NSManagedObject(entity: entity!, insertInto: context)
                
                manageObject.setValue(reposUrl, forKey: "reposUrl")
                manageObject.setValue(userName, forKey: "userName")
                manageObject.setValue(watchCount, forKey: "watchCount")
                manageObject.setValue(starCount, forKey: "starCount")
                manageObject.setValue(forkCount, forKey: "forkCount")
                manageObject.setValue(reposName, forKey: "reposName")
                
                do {
                    try context.save()
                }catch{
                    print("Save in context Error")
                }
            }
        }
    }
    class func deleteObject(obj: NSManagedObject){
        let context = getContext()
        context.delete(obj)
        do{
            try context.save()
            
        }catch{
            print("Delete error")
        }
    }
    class func fetchResultControllerFunc(compliteHandler: @escaping(_ result: Bool)-> Void){
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {

                let context = getContext()
                let request = FavoritesRepositories.createFetchRequest()
                request.sortDescriptors = [
                    NSSortDescriptor(key: "userName.reposName", ascending: true),
                NSSortDescriptor(key: "reposName", ascending: true)]
                
                let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                
                
                do{
                    try fetchedResultsController.performFetch()
                    favoritesData = fetchedResultsController.fetchedObjects!
                    compliteHandler(true)
                    
                }catch{
                    compliteHandler(false)
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
            }
        }
    }
    
    
}

