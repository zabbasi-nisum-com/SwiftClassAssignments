//: Playground - noun: a place where people can play

import UIKit

var str = "Error Handel with Throw.."

enum Errors:Error {
    case WrongTurn
    case LowBridge
}

func continueForwards(country:String) throws -> Bool  {
    
    if country == "USA" {
        return true
    }
    throw Errors.WrongTurn
    
}
do {
    try continueForwards(country: "India")
}
catch Errors.WrongTurn {
    "Wrong turn!"
}
catch let error {
    print("Default Error..")
}
