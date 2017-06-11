//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

@available(iOS 10.0, macOS 10.12, *)

class Item : Bin {
    var itemName: String?
}

class Bin : Location {
    var binName : String?
}

class Location  {
    var locationName: String?
}

var itemClass : Item?
itemClass = Item()
itemClass?.itemName = "Hello"
itemClass?.binName = "Good Morning"
itemClass?.locationName = "India"

if itemClass != nil {
    print(" \(String(describing: (itemClass?.itemName)!))")
    print(" \(String(describing: (itemClass?.binName)!))")
    print(" \(String(describing: (itemClass?.locationName)!))")
}



