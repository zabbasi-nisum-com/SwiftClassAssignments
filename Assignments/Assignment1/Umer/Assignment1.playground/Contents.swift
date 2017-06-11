//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//Location Class
class Location {
    
    var locationName: String!
    
    init (locationName: String) {
        self.locationName = locationName
    }
}

//Bin Class
class Bin : Location {
    var binName: String!
    
    init(binName: String, locationName: String) {
        super.init(locationName: locationName)
        self.binName = binName
    }
}

//Item Class
class Item : Bin {
    
    var itemName : String!
    
    init(itemName : String, binName : String , locationName : String) {
        super.init(binName : binName, locationName: locationName)
        self.itemName = itemName
    }
    
}


var itemObject : Item?

itemObject =  Item.init(itemName: "Mobile", binName: "Shop", locationName: "Karachi")


if itemObject != nil
{
    print ("The Itm Name is \((itemObject?.binName)!)")
}
