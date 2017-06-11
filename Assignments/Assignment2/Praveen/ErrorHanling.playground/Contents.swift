//: Playground - noun: a place where people can play

import UIKit
import Foundation

//var str = "Error Handling"

//Enum Declare

enum InputError : Error {
    case makeMissing
    case mileageTooLow(Int)
    case mileageTooHigh(Int)
}

//Class Declaration 
// Funcation contain String and int value Return Type Throws

func shouldBuyCar(make: String?, mileage: Int) throws {
    guard make == nil else {
        throw InputError.makeMissing
    }
    switch mileage {
    case mileage where mileage < 10:
        throw InputError.mileageTooLow(mileage)
    default:
        print("Default Loop 111!")
    }
}

do {
    try shouldBuyCar(make: "PraveensBike", mileage:120)
}
catch InputError.makeMissing {
    print("Missing make")
}
catch let InputError.mileageTooHigh(x) {
    print("Mileage too high")
}
catch {
    print("\(error)")
}

