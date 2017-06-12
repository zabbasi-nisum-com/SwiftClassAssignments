//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum ErrorHandling : Error{
    case Success
    case Failure
}

func responseCode200(success: String) throws -> Bool {
    if success == "200" {
        return true
    }
    throw ErrorHandling.Success
}

do {
    try responseCode200(success: "201")
}
catch ErrorHandling.Success {
    "Success"
}
catch let error {
    print("Error")
}