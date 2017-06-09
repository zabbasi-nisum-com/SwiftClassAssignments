//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum EntityType {
    case Bin
    case Item
    case Location
}

protocol EntityObject : class {
    var name: String? {get set}
}

class Location : EntityObject {
    var entityType : EntityType {
        return .Location
    }
    var name: String?
    
    init(locationName : String) {
        self.name = locationName
    }
}

class Bin : EntityObject {
    var entityName : EntityType {
        return .Bin
    }
    var name: String?
    var location : Location?
    init(binObject : String?, Location : Location?) {
        self.name = binObject
        self.location = Location
    }
}

class Item : EntityObject {
    var entityType : EntityType {
        return .Item
    }
    var name : String?
    var binObject : Bin?
    init(itemObject : String? , bin : Bin?) {
        self.name  = itemObject
        self.binObject = bin
    }
}


var itemObj : Item?
var binObj : Bin?
var locationObj : Location?

locationObj = Location(locationName: "")
binObj = Bin(binObject: "Hello", Location: locationObj)
itemObj = Item.init(itemObject: "Nisum", bin: binObj)

func printingData(entityObject : EntityType)  {
    
    switch entityObject {
        case .Location :
            print("The name is \(locationObj?.name)")
        case .Item :
            print("The name is \(itemObj?.name)")
        case .Bin :
            print("The name is \(binObj?.name)")
    
        }
}


