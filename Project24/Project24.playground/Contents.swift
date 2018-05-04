//: Playground - noun: a place where people can play

import UIKit

//extension Int {
//    func plusOne() -> Int {
//        return self + 1
//    }
//}

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

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let i: Int = 8
print(i.squared())
