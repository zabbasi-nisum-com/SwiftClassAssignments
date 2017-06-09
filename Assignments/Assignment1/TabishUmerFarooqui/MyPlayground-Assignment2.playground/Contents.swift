//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: Playground - noun: a place where people can play

import UIKit

protocol EntityObject:class {
    var productName: String { get set }
}
    
enum checkName: Error {
    case nameNotGiven
    case invalidName
}

class item {
    
    //initialize string
    var name = String()
    
    //Optional chaning
    var bn: bin?
    
    init(bi :String , lo :String) {
        print("item init")
        bn = bin(bn: bi,Loc: lo)
    }
    
    weak var EntityObject:EntityObject?
    
    var productName: String {
        get {
            return name
        }
        set(newValue) {
            name = newValue
        }
        
    }
    
    func persist(itemNamed name: String?) throws {
        if name != nil {
            print("Item name exception is \(String(describing: (name)!))")
        }
            
        else {
            throw checkName.nameNotGiven
        }
    }
}

class bin {
    
    //initialize string
    var name = String()
    
    //Optional chaning
    var lc : location?
    
    init(bn :String , Loc :String) {
        self.name = bn;
        lc = location(loc: Loc)
        print("Bin init")
    }
    
    weak var EntityObject:EntityObject?
    
    var productName: String {
        get {
            return name
        }
        set(newValue) {
            name = newValue
            print("update Bin")
            
        }
        
    }
}

class location {
    
    //initialize string
    var name = String()
    
    init(loc :String) {
        self.name = loc;
        print("Location init")
    }
    
    var productName: String {
        get {
            return name
        }
        set(newValue) {
            name = newValue
            print("update location")
            
        }
        
    }
}

//initializing
var itemMaster:item?
itemMaster = item(bi :"Information Technology" , lo :"Central Library")

itemMaster?.bn?.productName = "Software Engineering"
itemMaster?.bn?.lc?.productName = "Main Library"

//print("AS-2 Problem 1: \n \(String(describing: (itemMaster?.bn?.lc?.name)!))")

//Problem no. 3

//enum checkName: Error {
//    case nameNotGiven
//}
//
//func persist(itemNamed name: String) throws {
//    guard (itemMaster?.name) != nil else {
//        throw checkName.nameNotGiven
//    }
//    
//    print("Item name is \(String(describing: (itemMaster?.bn?.lc?.name)!))")
//}

do {
    try itemMaster?.persist(itemNamed: nil)
} catch checkName.nameNotGiven {
    print("Name not given.")
} catch checkName.invalidName {
    print("Invalid Name")
}

do {
    try itemMaster?.persist(itemNamed: "Tabish")
}

print("The given name is Tabish")
