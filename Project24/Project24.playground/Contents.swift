//: Playground - noun: a place where people can play

import UIKit

extension Int {
    mutating func plusOne() -> Int {
        self += 1
        return self
    }
}

var myInt = 0
myInt.plusOne()
myInt

//5.plusOne()
