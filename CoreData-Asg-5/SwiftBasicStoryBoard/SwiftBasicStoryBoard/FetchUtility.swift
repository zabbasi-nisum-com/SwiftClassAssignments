//
//  FetchUtility.swift
//  ExampleProject
//
//  Created by Patrick Sculley on 6/19/17.
//  Copyright © 2017 PixelFlow. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class FetchUtility  {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchSortedLocation() -> [Location]?    {
        do {
            let fetchRequest = NSFetchRequest<Location>(entityName: "Location")
            fetchRequest.predicate = NSPredicate(format: "entityModelType == %@", "Location")
            let nameSort = NSSortDescriptor(key: "name", ascending: true)
            let entityTypeSort = NSSortDescriptor(key: "entityModelType", ascending: true)
            fetchRequest.sortDescriptors = [nameSort, entityTypeSort]
            return try context.fetch(fetchRequest)
        } catch {
            print("fetchSortedLocation error: \(error.localizedDescription)")
        }
        return nil
    }
    
    func fetchLocation(byName:String) -> Location?    {
        do {
            let fetchRequest = NSFetchRequest<Location>(entityName: "Location")
            fetchRequest.predicate = NSPredicate(format: "name == %@", byName)
            var fetchResults = try context.fetch(fetchRequest)
            if fetchResults.count > 0 {
                return fetchResults[0]
            }
        } catch {
            print("fetchLocation error: \(error.localizedDescription)")
        }
        return nil
    }

}
