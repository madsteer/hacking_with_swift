//
//  Model.swift
//  Project17
//
//  Created by Cory Steers on 4/3/18.
//  Copyright © 2018 Cory Steers. All rights reserved.
//

import Foundation

enum ForceBomb: Int {
    case always = 0, never, random

    static func randomize() -> ForceBomb {
        let randomInt = Int(arc4random_uniform(UInt32((6 - 0) + 1))) + 0
        return randomInt == 0 ? .always : .never
    }
}

enum SequenceType: Int {
    case oneNoBomb, one, twoWithOneBomb, two, three, four, chain, fastChain
}
