//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Bike {
    var name: String?
    var price: Double?
}

func findStockCode(company: String) -> Bike? {
    if (company == "Suzuki") {
        let bike: Bike = Bike()
        bike.name = "Suzuki"
        bike.price = 90.32
        return bike
        
    } else if (company == "Yemaha") {
        let bike: Bike = Bike()
        bike.name = "Yemaha"
        bike.price = 556.36
        return bike
    }
    
    return nil
}

if let sharePrice = findStockCode(company: "Suzuki")?.price {
    let totalCost = sharePrice * 100
    print(totalCost)
}

