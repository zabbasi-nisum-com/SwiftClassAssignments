

import UIKit

enum EntityType {
    
    case ItemType
    case BinType
    case LocationType
    
}

enum ValueType : Error {
    
    case NilValue
    case NilObject
}

protocol EntityObject : class {
    var name : String? {get set}
    func updatedValue()

}
class Location  : EntityObject  {
    var entityType : EntityType {  return .LocationType}
    
    var name : String?
    
    init (locName : String?){
        self.name = locName
        
    }
    deinit {
        print("location Object deinitialized")
    }
    
    func updatedValue() {
       
    }
  
}
class Bin : EntityObject {
    
    var entityType: EntityType  { return .BinType}
    var name : String?
    weak var location : Location?
    init(binName : String?,Location : Location?) {
        
        self.name = binName
        self.location = Location
    }
    deinit {
        print("Bin Object deinitialized")
    }
    func updatedValue() {
        
    }
    
}

class Item : EntityObject {
    
    var entityType: EntityType  { return .ItemType}
    var name : String?
    weak var binObj : Bin?
    
    init(itemName : String?, bin : Bin?) {
        
        self.name = itemName
        self.binObj = bin
    }
    deinit {
        print("Item Object deinitialized")
    }
    func updatedValue() {
        print()
    }
}



var itemObj: Item?
var binObj: Bin?
var locObj: Location?

locObj = Location(locName: nil)
binObj = Bin(binName: "Drawer", Location: locObj)
itemObj =  Item.init(itemName: "Mobile", bin: binObj)





func persist(dataObj : EntityObject?, entityType : EntityType )throws {
    
    if dataObj != nil{
        switch entityType{
        
        case .LocationType : if let name = (dataObj as! Location).name {
            print ("name is \(name)")
        } else {
            throw ValueType.NilValue
            
            }
        case .ItemType : if let name = (dataObj as! Item).name {
            print ("name is \(name)")
        } else {
                throw ValueType.NilValue
            
            }
        case .BinType :  if let name = (dataObj as! Bin).name {
            print ("name is \(name)")
        } else {
            throw ValueType.NilValue
            
            }
        }
        
    } else{
    
        throw ValueType.NilObject
    }


}

do {
    
    try persist(dataObj: itemObj?.binObj?.location  , entityType: .LocationType)
} catch ValueType.NilValue{
    
    print("\(ValueType.NilValue) cannot print nil value ")
    
} catch ValueType.NilObject{

    print ("\(ValueType.NilObject) Object is nil")


}


//: problem 1





    




//: Assignment num 2





