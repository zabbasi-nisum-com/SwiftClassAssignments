//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//Declare protocal

protocol ProtocolObject{
    func makeDirectionCall() -> String
    var value:Int { get set }
}

class East:ProtocolObject{
    var value: Int = 1
    func makeDirectionCall() -> String {
        return "EAST"
    }
}

class West:ProtocolObject{
    var value: Int = 2
    func makeDirectionCall() -> String {
        return "WEST"
    }
}
class North:ProtocolObject{
    var value: Int = 3
    func makeDirectionCall() -> String {
        return "NORTH"
    }
}

class South:ProtocolObject{
    var value: Int = 3
    func makeDirectionCall() -> String {
        return "SOUTH"
    }
}


var directions:[ProtocolObject] = [East(), West(),North(),South()]
for object in directions{
    print(object.makeDirectionCall())
    object.value
}
