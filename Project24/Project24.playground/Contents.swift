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
i.squared()

extension BinaryInteger {
    func squared() -> Self {
        return self * self
    }
}

let u: UInt = 8
u.squared()
let u64: UInt64 = 8
u64.squared()
let u8: UInt8 = 8
u8.squared()

