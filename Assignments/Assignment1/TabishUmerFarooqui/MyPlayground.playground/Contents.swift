//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Assignment no. 1 
// Problem no. 1

// My personal Books (Item) go inside a Shelf (Bin) in my Library (Location)

class myBooks : myShelf {// Item Class
    var bookName: String?
}

class myShelf : myLibrary {// Bin class
    var shelfName: String?
}

class myLibrary {// Location Class
    var libraryName: String?
}

var optionalValue:myBooks?
optionalValue = myBooks()

optionalValue?.shelfName = "Information Technology"
optionalValue?.libraryName = "Central Library"
optionalValue?.bookName = "Learning Swift Programming Basics"

if optionalValue != nil {
    print(" \(String(describing: (optionalValue?.bookName)!))")

}

