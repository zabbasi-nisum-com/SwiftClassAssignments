//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol EntityObject:class {
    var pname: String { get set }
    
    
}

enum checkName: Error {
    case nameNotGiven
    case InvalidName
    
}


class item:EntityObject {
    
    //initialize string
    var name = String()
    
    //Optional chaning
    var bn: bin?
    
    init(bi :String , lo :String) {
        print("item init---")
        bn = bin(bn: bi,Loc: lo)
    }
    
    weak var EntityObject:EntityObject?
    
    //GET OR SET Property
    var pname: String {
        get {
            return name
        }
        set(newValue) {
            // ... do whatever is appropriate ...
            name = newValue
        }
        
    }
    
    
    //here we check exception
    func persist(itemNamed name: String?) throws {
        
        switch (name) {
        case .some(name!):
            print("Passing name exception is \(String(describing: (name)!))")
        default:
            throw checkName.InvalidName
        }
    }
    
}

class bin:EntityObject{
    
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
    
    
    var pname: String {
        get {
            return name
        }
        set(newValue) {
            // ... do whatever is appropriate ...
            name = newValue
            print("Update Bin")
            
        }
        
    }
    
    
}

class location:EntityObject{
    
    //initialize string
    var name = String()
    
    init(loc :String) {
        self.name = loc;
        print("Location init")
    }
    
    var pname: String {
        get {
            return name
        }
        set(newValue) {
            // ... do whatever is appropriate ...
            name = newValue
            print("update location")
            
        }
        
    }
    
    
}
//Problem 1:
var itemMaster:item?
itemMaster = item(bi :"BinCheck" , lo :"Karachi-Shop")

print("Set bin  & location \n \(String(describing: (itemMaster?.bn?.name)!)),\(String(describing: (itemMaster?.bn?.lc?.name)!))")

itemMaster?.bn?.EntityObject?.pname = "ABC"

//Problem 2: Update values
itemMaster?.bn?.pname = "BinCheck"
itemMaster?.bn?.lc?.pname = "Hyd-Shop"


print("Protocol updated bin ,location \n \(String(describing: (itemMaster?.bn?.name)!)),\(String(describing: (itemMaster?.bn?.lc?.name)!))")

//Problem 3:
//Passing Nil
do {
    
    //Here we pass nil for checking Persist Behavior
    try itemMaster?.persist(itemNamed: nil)
    
} catch checkName.InvalidName{
    print("Invalid Name.")
}

//Passing Name
do {
    
    //Here we pass nil for checking Persist Behavior
    try itemMaster?.persist(itemNamed: "Pakistan")
    
}