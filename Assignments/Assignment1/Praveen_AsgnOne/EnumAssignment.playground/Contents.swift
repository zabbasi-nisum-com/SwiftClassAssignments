//: Playground - noun: a place where people can play


/*
 Problem 2)
 1 . Declare an enum called EntityType with values Item, Location, Bin
 2 .Add the entityType property to each of the classes Item, Location, Bin and set the EntityType as a default value
 3.Create an array that includes an instance of all 3 classes Item, Location, Bin
 4.create a for in loop over the array that contains a switch statement
 5.print the following in each of the cases: "<name> is a <entityType> instance"
 
*/
import UIKit

var str = "WelCome To Enum Assginemnt :-)"

//: Playground - noun: a place where people can play


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
        print("The name is \(locationObj!.name)")
    case .Item :
        print("The name is \(itemObj!.name)")
    case .Bin :
        print("The name is \(binObj!.name)")
        
    }
}