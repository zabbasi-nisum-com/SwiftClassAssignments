//: Playground - noun: a place where people can play

import UIKit

var str = "Protocol Assignment"

//Declare protocal

protocol EntityObject{
    func makeStringCall() -> String
    var value:Int { get set }
}

class Item:EntityObject{
    var value: Int = 1
    func makeStringCall() -> String {
        return "Item Return"
    }
}

class Location:EntityObject{
    var value: Int = 2
    func makeStringCall() -> String {
        return "Location Return"
    }
}
class Bin:EntityObject{
    var value: Int = 3
    func makeStringCall() -> String {
        return "Bin Return"
    }
}


var animals:[EntityObject] = [Item(), Location(),Bin()]
for a in animals{
    print(a.makeStringCall())
    a.value
}
