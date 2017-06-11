//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Assignment no. 1 
// Problem no. 1

// My personal Books (Item) go inside a Shelf (Bin) in my Library (Location)

// Item Class
class MyBooks: MyShelf {
    var bookName: String?
}

// Bin class
class MyShelf:MyLibrary {
    var shelfName: String?
}

// Location Class
class MyLibrary {
    var libraryName: String?
}

var optionalValue: MyBooks?
optionalValue = MyBooks()

optionalValue?.shelfName = "Information Technology"
optionalValue?.libraryName = "Central Library"
optionalValue?.bookName = "Learning Swift Programming Basics"

if optionalValue != nil {
    print(" \(String(describing: (optionalValue?.bookName)!))")

}