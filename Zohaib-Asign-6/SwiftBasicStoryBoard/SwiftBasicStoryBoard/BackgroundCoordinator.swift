//
//  BackgroundCoordinator.swift
//  SwiftBasicStoryBoard
//
//  Created by Zohaib Aziz on 30/06/2017.
//  Copyright © 2017 NISUM. All rights reserved.
//

import CoreData
import UIKit
import Foundation

class BackgroundCoordinator {
    
    func requestAndLoadEntities(objectType:String)    {
        let context:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
        
        context.perform {
            let dataLoad:DataLoad = DataLoad(context: context)
            let dataService:DataService = DataService()
            dataService.doURLRequest(objectType: objectType, responseHandler:{
                (array:[Any]) -> Void in
                for object in array {
                    if let jsonDictionary = object as? Dictionary<String, Any> {
                        for (key, value) in jsonDictionary {
                            print("got \(key): \(value)")
                        }
                        
                        
                    let item = dataLoad.loadItem(fromJSON:jsonDictionary)
                        
                        print("Loaded item: \(item.name)")
                    }
                }
            })
        }
    }

    
}
