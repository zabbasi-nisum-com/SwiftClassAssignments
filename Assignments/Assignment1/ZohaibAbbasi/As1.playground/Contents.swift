//: Playground - noun: a place where people can play

import UIKit

class item : bin{

    //initialize string
    var name = String()
    
   
    //here we set values
    func setParameters(nam: String, bin:String, loc:String) {
        self.name = nam
        self.binname = bin
        self.locname = loc
    }


}

class bin : location{
    
    //initialize string
    var binname = String()

}

class location{

    //initialize string
    var locname = String()

}

//initializing
var someOptional:item?
someOptional = item()

//here we passing a values
someOptional?.setParameters(nam: "BOOK", bin: "Bin-Code", loc: "PK")


//Here we check
if someOptional != nil {
    print("Class assignment one: \n \(someOptional!.name) ,\(someOptional!.binname) ,\(String(describing: (someOptional?.locname)!))")
}



