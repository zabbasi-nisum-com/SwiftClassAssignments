//
//  DataLoad.swift
//  SwiftBasicStoryBoard
//
//  Created by Zohaib Aziz on 29/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import CoreData
import UIKit
import Foundation


class DataLoad {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dataFetch :DataFetch = DataFetch()
    
    init(context:NSManagedObjectContext) {
        self.context = context
        self.dataFetch = DataFetch(context :context)
        
    }
    
    func loadItem(fromJSON:Dictionary<String,Any>) -> Item {
        var item:Item? = dataFetch.fetchEntity(byId: fromJSON["id"]as! NSNumber)
        
        if item == nil {
            item = Item(context: context)
        }
        
        item?.setPropertiesFrom(jsonDictionary: fromJSON)
        if let binJSON = fromJSON["bin"] as? Dictionary<String ,Any>{
            let bin = loadBin(fromJSON:binJSON)
            item?.itemtoBin = bin
        
        }
        self.saveContext()
        return item!
    }
    
    func loadBin(fromJSON:Dictionary<String,Any>) -> Bin {
        var bin:Bin? = dataFetch.fetchEntity(byId: fromJSON["id"]as! NSNumber)
        
        if bin == nil {
            bin = Bin(context: context)
        }
        
        bin?.setPropertiesFrom(jsonDictionary: fromJSON)
        if let locJSON = fromJSON["location"] as? Dictionary<String ,Any>{
            let loc = loadLocation(fromJSON:locJSON)
            bin?.binToLoc = loc
            
        }
        self.saveContext()
        return bin!
    }
    
    
    func loadLocation(fromJSON:Dictionary<String,Any>) -> Location {
        var loc:Location? = dataFetch.fetchEntity(byId: fromJSON["id"]as! NSNumber)
        
        if loc == nil {
            loc = Location(context: context)
        }
        
        loc?.setPropertiesFrom(jsonDictionary: fromJSON)

        self.saveContext()
        return loc!
    }

    
    func saveContext()  {
        if context.hasChanges {
            do {
                try context.save()
            } catch  {
                let nserror = error as NSError
                fatalError("Unressolved error \(nserror),\(nserror.userInfo)")
            }
        }
    }
}
