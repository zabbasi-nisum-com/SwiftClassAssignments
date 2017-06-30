//
//  DataFetch.swift
//  SwiftBasicStoryBoard
//
//  Created by Zohaib Aziz on 29/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import CoreData
import UIKit
import Foundation

class DataFetch{
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init() {
        context.automaticallyMergesChangesFromParent = true
    }
    
   convenience init(context:NSManagedObjectContext) {
        self.init()
        self.context = context
    }
    
    func fetchEntity<T :EntityBase>(byId:NSNumber) -> T? {
        
        do{
            let objectTypeName = String(describing:type(of: T.self)).replacingOccurrences(of: ".Type", with: "")
            let fetchRequest = NSFetchRequest<T>(entityName:objectTypeName)
            
            fetchRequest.predicate = NSPredicate(format: "id == %@", byId)
            
            let array = try self.context.fetch(fetchRequest)
            let entity:T? = (array.count > 0 ) ? (array[0]) : nil
            
            return entity
        
        }catch{
        
            print("Fetching Entity Failed")
        }
        
        return nil
    }
    
    
    func getFetchedResultsController<T:EntityBase>() -> NSFetchedResultsController<T> {

        let objectTypeName = String(describing:type(of: T.self)).replacingOccurrences(of: ".Type", with: "")
        let fetchRequest = NSFetchRequest<T>(entityName:objectTypeName)
        let nameSort = NSSortDescriptor(key:"name",ascending:true)
        fetchRequest.sortDescriptors  = [nameSort]
        
        return NSFetchedResultsController<T>(fetchRequest: fetchRequest ,managedObjectContext:context, sectionNameKeyPath:nil , cacheName:nil)
        
    }
    
}
