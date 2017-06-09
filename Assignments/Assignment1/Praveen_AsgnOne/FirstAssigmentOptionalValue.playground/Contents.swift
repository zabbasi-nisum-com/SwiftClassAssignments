//: Playground - noun: a place where people can play

import UIKit

var str = "WelCome to First Assginment OptionValue"

//Assginment No :1

@available(iOS 10.0, macOS 10.12, *)


class Location  {
    var locationName: String?
}
class Bin : Location {
    var binName : String?
}
class Item : Bin {
    var itemName: String?
}

var itemClass : Item?
itemClass = Item()
itemClass?.itemName = "apple"
itemClass?.binName = "Good For Health"
itemClass?.locationName = "Hyderabad ,India"

if itemClass != nil {
    print(" \(String(describing: (itemClass?.itemName)!))")
    print(" \(String(describing: (itemClass?.binName)!))")
    print(" \(String(describing: (itemClass?.locationName)!))")
}

