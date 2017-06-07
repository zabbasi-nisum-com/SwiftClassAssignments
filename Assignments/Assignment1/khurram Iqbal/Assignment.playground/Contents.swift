
//: Playground - noun: a place where people can play

import UIKit

enum EntityType {
    
    case ItemType
    case BinType
    case LocationType
    
}
class Location {
    var entityType : EntityType {  return .LocationType}
    var locName : String! = ""
    var name : String! {return locName!}
    
    init (locName : String){
        self.locName = locName
        
    }
    init (){
        
    }
}
class Bin : Location{
    
    
    var binName: String! = ""
    override var entityType: EntityType  { return .BinType}
    override var name : String{return binName}
    
    init(binName : String,locName : String) {
        super.init(locName: locName)
        self.binName = binName
        
    }
    
    override init(){
        super.init()
    }
}

class Item : Bin {
    var itemName : String! = ""
    override var entityType: EntityType  { return .ItemType}
    override var name : String{return itemName}
    
    
    
    init(itemName : String, binName : String , locName : String) {
        super.init(binName : binName,locName: locName)
        self.itemName = itemName
    }
    override init() {
        super.init()
    }
    
}



var itemObj : Item?

//problem 1

itemObj =  Item.init(itemName: "iPhone", binName: "1st Shelf", locName: "Nisum Office")
//    itemObj = Item.init()
//    itemObj?.itemName = "iPhone"


if itemObj != nil{
    print ("The name of item is \((itemObj?.name)!)")
}




