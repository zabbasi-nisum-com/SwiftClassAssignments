//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var arr : [String : AnyObject] = [String:AnyObject]()
arr.updateValue(["hello"] as AnyObject, forKey: "1")
print(arr["1"] ?? "")

arr.updateValue(["key1":"hello2","key2":"hello3"] as AnyObject, forKey: "2")
print(arr["2"] ?? "")

var k = arr["1"] as! NSArray


print(k)

